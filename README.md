# Divisor de cuenta (SDD)

Aplicación Flutter de una pantalla para dividir el total de una cuenta, incluida la propina, entre varias personas. Funciona sin conexión y no guarda datos.

## Uso

```powershell
flutter pub get
flutter run
```

Ingresa monto, personas y propina; selecciona **Exacto** o **Hacia arriba al entero** y pulsa **Calcular**.

## Arquitectura

- `lib/domain/`: cuenta, resultado, validación, cálculo e interfaz de redondeo en Dart puro.
- `lib/data/`: estrategias exacta y hacia arriba.
- `lib/presentation/`: controller, formateador y pantalla.
- `lib/main.dart`: composición de dependencias.

La presentación depende del dominio; datos implementa la estrategia del dominio.

## Verificación

```powershell
flutter test
flutter test --reporter expanded
flutter analyze
flutter build apk --debug
```

Los escenarios de aceptación viven en `test/casos_de_prueba.dart`; `test/division_test.dart` los ejecuta sobre el dominio y `test/pantalla_test.dart` comprueba la pantalla.
