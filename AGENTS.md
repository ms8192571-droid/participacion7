# Instrucciones del proyecto

- App Flutter sin conexión, de una sola pantalla, para dividir una cuenta.
- Estructura: `lib/presentation`, `lib/domain` y `lib/data`; dependencias `presentation -> domain <- data`.
- `lib/domain` es Dart puro y no importa `package:flutter`.
- Usa null safety, nombres en español y ningún paquete externo.
- No modifiques `test/` salvo que la solicitud lo pida; no agregues dependencias a `pubspec.yaml` sin autorización; no modifiques `android/` ni `ios/`.
- Comandos: `flutter pub get`, `flutter run`, `flutter analyze`, `flutter test`.
