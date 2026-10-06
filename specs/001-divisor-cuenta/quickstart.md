# Validación rápida

## Requisitos

- Flutter estable y Dart incluidos en el SDK.
- No se necesita conexión, cuenta externa ni base de datos.

## Comandos

```powershell
flutter pub get
flutter test
flutter test --reporter expanded
flutter analyze
flutter build apk --debug
```

## Resultados esperados

- Las pruebas enumeran y pasan los seis escenarios de aceptación, la sustitución LSP y las tres pruebas de widget.
- `flutter analyze` termina sin issues.
- `flutter build apk --debug` termina con código 0 en una máquina con Android SDK configurado.
- Un cálculo manual de 100.00, 4 personas, 10% y modo exacto muestra `27.50`.
