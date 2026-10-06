import '../domain/estrategia_redondeo.dart';

class RedondeoHaciaArriba implements EstrategiaRedondeo {
  @override
  double redondear(double importePorPersona) {
    return importePorPersona.ceilToDouble();
  }
}
