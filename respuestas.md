# Respuestas

1. **Rojo antes de verde.** La prueba para una propina del 150% esperaba exactamente `La propina no puede superar el 100%`, pero `flutter test` mostró que el resultado real era `null`. Ver fallar la prueba antes de implementar permitió confirmar que detectaba la regla faltante y que el cambio posterior era lo que la hacía pasar.

2. **Linter vs. IA.** En las ejecuciones de `flutter analyze` de esta sesión no aparecieron avisos: mostró `No issues found!`. La IA señaló como code smell que `main.dart` creaba el controller dentro de `build`. El linter no lo detectó porque es válido sintácticamente y no infringe las reglas configuradas, aunque una reconstrucción pudiera crear otro controller y perder el estado previo.

3. **Tu refactorización.** Elegí la recreación del controller dentro de `build`. Cambié `MyApp` de `StatelessWidget` a `StatefulWidget` y conservé el controller y el formateador en su estado, para no volver a crearlos en cada reconstrucción. `flutter test` pasó después del cambio y no se modificó la lógica del cálculo; esto verifica las conductas cubiertas por las pruebas, aunque no demuestra todos los comportamientos posibles.

4. **Coverage.** Según `coverage/lcov.info`, `lib/main.dart` tenía el porcentaje más bajo: **81,82 %** (9 de 11 líneas). Eso no significa que tenga errores: indica que algunas líneas no se ejecutaron durante las pruebas, no que su comportamiento sea incorrecto.
