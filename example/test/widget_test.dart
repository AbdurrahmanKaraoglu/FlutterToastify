import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

/// Tipik bir telefon ekranı (411x914 mantıksal piksel).
void _phone(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2.625;
  addTearDown(tester.view.reset);
}

Future<void> _open(WidgetTester tester, String scenario) async {
  await tester.ensureVisible(find.text(scenario));
  await tester.pumpAndSettle();
  await tester.tap(find.text(scenario));
  // İlk kare giriş animasyonunu başlatır, sonraki kareler onu tamamlar.
  await tester.pump();
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets('örnek bildirim açılır ve kendiliğinden kapanır', (tester) async {
    _phone(tester);
    await tester.pumpWidget(const MyApp());
    await _open(tester, 'Başarılı işlem');

    expect(find.text('Verileriniz güncellendi'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Verileriniz güncellendi'), findsNothing);
  });

  testWidgets('kalıcı bildirim kapatma düğmesiyle kapanır', (tester) async {
    _phone(tester);
    await tester.pumpWidget(const MyApp());
    await _open(tester, 'Kalıcı, başlıksız');
    expect(find.byIcon(Icons.access_alarm), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.access_alarm), findsNothing);
  });

  testWidgets('özel kapatma düğmesi bildirimi kapatır', (tester) async {
    _phone(tester);
    await tester.pumpWidget(const MyApp());
    await _open(tester, 'Özel kapatma düğmesi');
    expect(find.text('Artık panele geçebilirsiniz.'), findsOneWidget);

    await tester.tap(find.byTooltip('Çıkış'));
    await tester.pumpAndSettle();
    expect(find.text('Artık panele geçebilirsiniz.'), findsNothing);
  });
}
