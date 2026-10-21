import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/extensions.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

const _toastDuration = Duration(milliseconds: 1000);
const _animationDuration = Duration(milliseconds: 300);

/// Bir düğmeye basıldığında [toast]'u gösteren test uygulaması.
Widget _app(FlutterToastify toast) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => toast.show(context),
          child: const Text('show'),
        ),
      ),
    ),
  );
}

Future<void> _show(WidgetTester tester, FlutterToastify toast) async {
  await tester.pumpWidget(_app(toast));
  await tester.tap(find.text('show'));
  // İlk kare giriş animasyonunu başlatır, sonraki kareler onu tamamlar.
  await tester.pump();
  await tester.pump();
  await tester.pump(_animationDuration);
}

void main() {
  testWidgets('başarı bildirimi gösterilir ve süre sonunda kendiliğinden kapanır', (tester) async {
    var finished = 0;
    final toast = FlutterToastify.success(
      title: const Text('Başlık'),
      description: const Text('Açıklama'),
      toastDuration: _toastDuration,
      animationDuration: _animationDuration,
      onProgressFinished: () => finished++,
    );

    await _show(tester, toast);
    expect(find.text('Başlık'), findsOneWidget);
    expect(find.text('Açıklama'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(toast.isShowing, isTrue);

    await tester.pump(_toastDuration);
    await tester.pumpAndSettle();

    expect(finished, 1);
    expect(toast.isShowing, isFalse);
    expect(find.text('Açıklama'), findsNothing);
  });

  testWidgets('kapatma düğmesi geri çağrıları tetikler ve bildirimi kaldırır', (tester) async {
    var closed = 0;
    var dismissed = 0;
    var finished = 0;
    final toast = FlutterToastify.error(
      description: const Text('Hata'),
      toastDuration: _toastDuration,
      animationDuration: _animationDuration,
      onCloseButtonPressed: () => closed++,
      onDismiss: () => dismissed++,
      onProgressFinished: () => finished++,
    );

    await _show(tester, toast);
    await tester.tap(find.byIcon(Icons.close));
    // Çıkış animasyonu sırasında ikinci dokunuş yok sayılmalı.
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byIcon(Icons.close), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(closed, 1);
    expect(dismissed, 1);
    expect(toast.isShowing, isFalse);
    expect(find.text('Hata'), findsNothing);

    // Otomatik kapanma zamanlayıcısı iptal edilmiş olmalı.
    await tester.pump(_toastDuration * 2);
    expect(finished, 0);
  });

  testWidgets('aynı bildirim iki kez gösterilmez', (tester) async {
    final toast = FlutterToastify.info(
      description: const Text('Bilgi'),
      toastDuration: _toastDuration,
      animationDuration: _animationDuration,
    );

    await _show(tester, toast);
    await tester.tap(find.text('show'));
    await tester.pump();

    expect(find.text('Bilgi'), findsOneWidget);

    await tester.pump(_toastDuration);
    await tester.pumpAndSettle();
    expect(find.text('Bilgi'), findsNothing);
  });

  testWidgets('autoDismiss kapalıyken bildirim ekranda kalır ve closeOverlay ile kapanır', (tester) async {
    final toast = FlutterToastify(
      description: const Text('Kalıcı'),
      icon: const Icon(Icons.alarm),
      autoDismiss: false,
      showProgressIndicator: false,
      animationDuration: _animationDuration,
    );

    await _show(tester, toast);
    await tester.pump(const Duration(seconds: 10));

    expect(find.text('Kalıcı'), findsOneWidget);
    expect(find.byIcon(Icons.alarm), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);

    toast.closeOverlay();
    await tester.pump();
    expect(find.text('Kalıcı'), findsNothing);
    expect(toast.isShowing, isFalse);
  });

  testWidgets('özel kapatma düğmesi dismiss fonksiyonunu alır', (tester) async {
    var dismissed = 0;
    final toast = FlutterToastify(
      description: const Text('Özel'),
      icon: null,
      autoDismiss: false,
      showProgressIndicator: false,
      animationDuration: _animationDuration,
      closeButton: (dismiss) => IconButton(
        onPressed: dismiss,
        icon: const Icon(Icons.logout),
      ),
      onDismiss: () => dismissed++,
    );

    await _show(tester, toast);
    expect(find.byIcon(Icons.close), findsNothing);

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    expect(dismissed, 1);
    expect(find.text('Özel'), findsNothing);
  });

  test('ilerleme göstergesi autoDismiss olmadan kullanılamaz', () {
    expect(
      () => FlutterToastify.success(
        description: const Text('x'),
        autoDismiss: false,
      ),
      throwsAssertionError,
    );
  });

  test('action verildiğinde onActionPressed zorunludur', () {
    expect(
      () => FlutterToastify.info(
        description: const Text('x'),
        action: const Text('Link'),
      ),
      throwsAssertionError,
    );
  });

  test('hazır stiller kendi renklerini kullanır', () {
    expect(
      FlutterToastify.success(description: const Text('x')).progressIndicatorColor,
      AppConstants.successColor,
    );
    expect(
      FlutterToastify.error(description: const Text('x')).progressIndicatorColor,
      AppConstants.errorColor,
    );
    expect(
      FlutterToastify.info(description: const Text('x')).progressIndicatorColor,
      AppConstants.inforColor,
    );
  });

  test('her konum doğru hizalamaya karşılık gelir', () {
    expect(NotificationPosition.center.alignment, Alignment.center);
    expect(NotificationPosition.topLeft.alignment, Alignment.topLeft);
    expect(NotificationPosition.topRight.alignment, Alignment.topRight);
    expect(NotificationPosition.bottomCenter.alignment, Alignment.bottomCenter);
    expect(NotificationPosition.centerLeft.alignment, Alignment.centerLeft);
  });
}
