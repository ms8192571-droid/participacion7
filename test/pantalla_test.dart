import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_participacion7/main.dart';

void main() {
  Future<void> ingresarYCalcular(
    WidgetTester tester, {
    required String monto,
    required String personas,
    required String propina,
  }) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byKey(const ValueKey('monto')), monto);
    await tester.enterText(find.byKey(const ValueKey('personas')), personas);
    await tester.enterText(find.byKey(const ValueKey('propina')), propina);
    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();
  }

  testWidgets('calcula y muestra el reparto con propina', (tester) async {
    await ingresarYCalcular(tester, monto: '100', personas: '4', propina: '10');

    expect(find.text('27.50'), findsOneWidget);
  });

  testWidgets('cero personas muestra error y no muestra resultado', (
    tester,
  ) async {
    await ingresarYCalcular(tester, monto: '50', personas: '0', propina: '0');

    expect(find.text('Debe haber al menos una persona'), findsOneWidget);
    expect(find.byKey(const ValueKey('resultado')), findsNothing);
  });

  testWidgets('monto no numérico muestra error', (tester) async {
    await ingresarYCalcular(tester, monto: 'abc', personas: '4', propina: '0');

    expect(find.text('Monto inválido'), findsOneWidget);
    expect(find.byKey(const ValueKey('resultado')), findsNothing);
  });
}
