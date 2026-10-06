import 'cuenta.dart';
import 'estrategia_redondeo.dart';
import 'resultado.dart';

class CalcularDivision {
  Resultado calcular(Cuenta cuenta, EstrategiaRedondeo estrategia) {
    final totalConPropina =
        cuenta.montoTotal * (1 + cuenta.porcentajePropina / 100);
    final importePorPersona = totalConPropina / cuenta.personas;
    return Resultado(
      montoPorPersona: estrategia.redondear(importePorPersona),
    );
  }
}
