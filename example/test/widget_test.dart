import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('örnek bildirim açılır ve kendiliğinden kapanır', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Başarılı tema bildirimi\n(sol üst)'));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Verileriniz güncellendi'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Verileriniz güncellendi'), findsNothing);
  });

  testWidgets('kalıcı bildirim kapatma düğmesiyle kapanır', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Başlık olmadan zarif bildirim\n(sağ alt)'));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byIcon(Icons.access_alarm), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.access_alarm), findsNothing);
  });
}
