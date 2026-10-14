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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = DivisorController(
    validarEntrada: ValidarEntrada(),
    calcularDivision: CalcularDivision(),
    redondeoExacto: RedondeoExacto(),
    redondeoHaciaArriba: RedondeoHaciaArriba(),
  );
  final formateador = FormateadorMoneda();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Divisor de cuenta',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.teal)),
      home: PantallaDivisor(
        controller: controller,
        formateador: formateador,
      ),
    );
  }
}
