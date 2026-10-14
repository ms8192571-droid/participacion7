import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_participacion7/domain/calcular_division.dart';
import 'package:flutter_participacion7/domain/cuenta.dart';
import 'package:flutter_participacion7/domain/estrategia_redondeo.dart';
import 'package:flutter_participacion7/domain/validar_entrada.dart';
import 'package:flutter_participacion7/data/redondeo_exacto.dart';
import 'package:flutter_participacion7/data/redondeo_hacia_arriba.dart';
import 'package:flutter_participacion7/presentation/divisor_controller.dart';

import 'casos_de_prueba.dart';

void main() {
  group('Criterios de aceptación', () {
    for (final caso in casos) {
      test(caso.nombre, () {
        final cuenta = Cuenta(
          montoTotal: caso.monto,
          personas: caso.personas,
          porcentajePropina: caso.propina,
        );
        final error = ValidarEntrada().validar(cuenta);

        if (caso.errorEsperado != null) {
          expect(error, caso.errorEsperado);
          final estrategiaEspia = _EstrategiaEspia();
          final controller = DivisorController(
            validarEntrada: ValidarEntrada(),
            calcularDivision: CalcularDivision(),
            redondeoExacto: estrategiaEspia,
            redondeoHaciaArriba: estrategiaEspia,
          );
          controller.calcular(
            monto: caso.monto.isNaN ? 'abc' : caso.monto.toString(),
            personas: caso.personas.toString(),
            propina: caso.propina.toString(),
            redondearHaciaArriba: caso.modo == 'arriba',
          );
          expect(controller.error, caso.errorEsperado);
          expect(controller.resultado, isNull);
          expect(estrategiaEspia.llamadas, 0);
          return;
        }

        expect(error, isNull);
        final estrategia = caso.modo == 'arriba'
            ? RedondeoHaciaArriba()
            : RedondeoExacto();
        final resultado = CalcularDivision().calcular(cuenta, estrategia);
        expect(resultado.montoPorPersona, closeTo(caso.esperado!, 0.001));
      });
    }
  });

  test('CalcularDivision acepta ambas estrategias sin preguntar su tipo', () {
    final calcularDivision = CalcularDivision();
    const cuenta = Cuenta(montoTotal: 10, personas: 3, porcentajePropina: 0);

    final exacto = calcularDivision.calcular(cuenta, RedondeoExacto());
    final haciaArriba = calcularDivision.calcular(
      cuenta,
      RedondeoHaciaArriba(),
    );

    expect(exacto.montoPorPersona, closeTo(3.33, 0.001));
    expect(haciaArriba.montoPorPersona, closeTo(4, 0.001));
  });

  test('rechaza una propina superior al 100%', () {
    const cuenta = Cuenta(
      montoTotal: 100,
      personas: 4,
      porcentajePropina: 150,
    );

    expect(
      ValidarEntrada().validar(cuenta),
      'La propina no puede superar el 100%',
    );
  });

  test('permite una propina exactamente del 100%', () {
    const cuenta = Cuenta(
      montoTotal: 100,
      personas: 4,
      porcentajePropina: 100,
    );

    expect(ValidarEntrada().validar(cuenta), isNull);
  });
}

class _EstrategiaEspia implements EstrategiaRedondeo {
  int llamadas = 0;

  @override
  double redondear(double importePorPersona) {
    llamadas++;
    return importePorPersona;
  }
}
