import '../domain/calcular_division.dart';
import '../domain/cuenta.dart';
import '../domain/estrategia_redondeo.dart';
import '../domain/resultado.dart';
import '../domain/validar_entrada.dart';

class DivisorController {
  final ValidarEntrada validarEntrada;
  final CalcularDivision calcularDivision;
  final EstrategiaRedondeo redondeoExacto;
  final EstrategiaRedondeo redondeoHaciaArriba;

  String? error;
  Resultado? resultado;

  DivisorController({
    required this.validarEntrada,
    required this.calcularDivision,
    required this.redondeoExacto,
    required this.redondeoHaciaArriba,
  });

  void calcular({
    required String monto,
    required String personas,
    required String propina,
    required bool redondearHaciaArriba,
  }) {
    final montoIngresado = double.tryParse(monto.trim()) ?? double.nan;
    final personasIngresadas = int.tryParse(personas.trim());
    final propinaIngresada = double.tryParse(propina.trim()) ?? double.nan;

    if (personasIngresadas == null) {
      _mostrarError('Número de personas inválido');
      return;
    }

    final cuenta = Cuenta(
      montoTotal: montoIngresado,
      personas: personasIngresadas,
      porcentajePropina: propinaIngresada,
    );
    final errorValidacion = validarEntrada.validar(cuenta);
    if (errorValidacion != null) {
      _mostrarError(errorValidacion);
      return;
    }

    final estrategia = redondearHaciaArriba
        ? redondeoHaciaArriba
        : redondeoExacto;
    resultado = calcularDivision.calcular(cuenta, estrategia);
    error = null;
  }

  void _mostrarError(String mensaje) {
    error = mensaje;
    resultado = null;
  }
}
