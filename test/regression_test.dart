import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

const _toastDuration = Duration(milliseconds: 1000);
const _animationDuration = Duration(milliseconds: 300);

Widget _materialApp(FlutterToastify toast) {
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

Future<void> _tapShow(WidgetTester tester) async {
  await tester.tap(find.text('show'));
  // İlk kare giriş animasyonunu başlatır, sonraki kareler onu tamamlar.
  await tester.pump();
  await tester.pump();
  await tester.pump(_animationDuration);
}

void main() {
  for (final platform in [TargetPlatform.iOS, TargetPlatform.macOS]) {
    testWidgets('MaterialLocalizations olmayan CupertinoApp içinde ${platform.name} üzerinde çalışır', (tester) async {
      debugDefaultTargetPlatformOverride = platform;
      try {
        final toast = FlutterToastify.success(
          description: const Text('Kaydedildi'),
          toastDuration: _toastDuration,
          animationDuration: _animationDuration,
        );
        await tester.pumpWidget(
          CupertinoApp(
            home: Builder(
              builder: (context) => CupertinoButton(
                onPressed: () => toast.show(context),
                child: const Text('show'),
              ),
            ),
          ),
        );
        await _tapShow(tester);
        expect(tester.takeException(), isNull);
        expect(find.text('Kaydedildi'), findsOneWidget);

        await tester.tap(find.bySemanticsLabel('Close'));
        await tester.pumpAndSettle();
        expect(find.text('Kaydedildi'), findsNothing);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });
  }

  testWidgets('uygulamanın DialogTheme ayarları bildirimi etkilemez', (tester) async {
    final toast = FlutterToastify.info(
      description: const Text('x'),
      width: 200,
      toastDuration: _toastDuration,
      animationDuration: _animationDuration,
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          dialogTheme: const DialogThemeData(backgroundColor: Colors.red, elevation: 24),
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(onPressed: () => toast.show(context), child: const Text('show')),
          ),
        ),
      ),
    );
    await _tapShow(tester);

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Dialog), findsNothing);
    final box = tester.getSize(find.byType(FlutterToastify));
    expect(box.width, 200);

    await tester.pump(_toastDuration);
    await tester.pumpAndSettle();
  });

  testWidgets('overlay yok edilirse bildirim kilitli kalmaz ve tekrar gösterilebilir', (tester) async {
    final toast = FlutterToastify(
      description: const Text('Kalıcı'),
      icon: const Icon(Icons.alarm),
      autoDismiss: false,
      showProgressIndicator: false,
      animationDuration: _animationDuration,
    );
    await tester.pumpWidget(_materialApp(toast));
    await _tapShow(tester);
    expect(toast.isShowing, isTrue);

    // Uygulama ağacı (ve onunla Overlay) tamamen değişir.
    await tester.pumpWidget(const SizedBox());
    expect(toast.isShowing, isFalse);
    expect(toast.closeOverlay, returnsNormally);

    await tester.pumpWidget(_materialApp(toast));
    await _tapShow(tester);
    expect(toast.isShowing, isTrue);
    expect(find.text('Kalıcı'), findsOneWidget);

    toast.closeOverlay();
    await tester.pump();
  });

  testWidgets('varsayılan kapatma düğmesi en az 48x48 ve etiketli', (tester) async {
    final handle = tester.ensureSemantics();
    final toast = FlutterToastify.error(
      description: const Text('Hata'),
      toastDuration: _toastDuration,
      animationDuration: _animationDuration,
    );
    await tester.pumpWidget(_materialApp(toast));
    await _tapShow(tester);

    final closeFinder = find.bySemanticsLabel('Close');
    expect(closeFinder, findsOneWidget);
    final size = tester.getSize(find.ancestor(of: find.byIcon(Icons.close), matching: find.byType(InkWell)));
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    await tester.pump(_toastDuration);
    await tester.pumpAndSettle();
    handle.dispose();
  });

  testWidgets('ilerleme çubuğu süreyle doğrusal ilerler', (tester) async {
    final toast = FlutterToastify.success(
      description: const Text('x'),
      toastDuration: _toastDuration,
      animationDuration: _animationDuration,
    );
    await tester.pumpWidget(_materialApp(toast));
    await tester.tap(find.text('show'));
    await tester.pump();

    double progress() => tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator)).value!;
    expect(progress(), closeTo(1.0, 0.01));

    await tester.pump(_toastDuration ~/ 4);
    expect(progress(), closeTo(0.75, 0.02));
    await tester.pump(_toastDuration ~/ 4);
    expect(progress(), closeTo(0.5, 0.02));

    await tester.pump(_toastDuration);
    await tester.pumpAndSettle();
  });
}
