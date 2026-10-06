import '../domain/estrategia_redondeo.dart';

class RedondeoExacto implements EstrategiaRedondeo {
  @override
  double redondear(double importePorPersona) {
    return (importePorPersona * 100).roundToDouble() / 100;
  }
}
