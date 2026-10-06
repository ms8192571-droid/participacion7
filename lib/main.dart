import 'package:flutter/material.dart';

import 'data/redondeo_exacto.dart';
import 'data/redondeo_hacia_arriba.dart';
import 'domain/calcular_division.dart';
import 'domain/validar_entrada.dart';
import 'presentation/divisor_controller.dart';
import 'presentation/formateador_moneda.dart';
import 'presentation/pantalla_divisor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DivisorController(
      validarEntrada: ValidarEntrada(),
      calcularDivision: CalcularDivision(),
      redondeoExacto: RedondeoExacto(),
      redondeoHaciaArriba: RedondeoHaciaArriba(),
    );
    return MaterialApp(
      title: 'Divisor de cuenta',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.teal)),
      home: PantallaDivisor(
        controller: controller,
        formateador: FormateadorMoneda(),
      ),
    );
  }
}
