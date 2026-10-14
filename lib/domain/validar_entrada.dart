import 'cuenta.dart';

class ValidarEntrada {
  String? validar(Cuenta cuenta) {
    if (!cuenta.montoTotal.isFinite || cuenta.montoTotal < 0) {
      return 'Monto inválido';
    }
    if (cuenta.personas < 1) {
      return 'Debe haber al menos una persona';
    }
    if (!cuenta.porcentajePropina.isFinite || cuenta.porcentajePropina < 0) {
      return 'Propina inválida';
    }
    if (cuenta.porcentajePropina > 100) {
      return 'La propina no puede superar el 100%';
    }
    return null;
  }
}
