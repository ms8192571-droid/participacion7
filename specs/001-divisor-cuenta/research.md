# Research: Divisor de cuenta

## Decision: Flutter estable y Dart del proyecto

- **Decision**: Usar el SDK Flutter estable instalado y Dart con null safety.
- **Rationale**: Es el stack requerido y permite una sola app sin dependencias adicionales.
- **Alternatives considered**: Añadir paquetes de estado o formato monetario; rechazados porque el alcance cabe en Flutter y Dart incluidos.

## Decision: Estado local con setState

- **Decision**: Mantener entradas y resultado en la pantalla; delegar validación y cálculo al controller y al dominio.
- **Rationale**: Solo existe una pantalla y no hay estado compartido, red ni persistencia.
- **Alternatives considered**: BLoC, Provider y almacenamiento; innecesarios para el alcance descrito.

## Decision: Cálculo monetario y precisión de presentación

- **Decision**: Aplicar propina al total, dividir por personas y redondear el resultado individual a centavos en modo exacto. La segunda estrategia usa techo al entero.
- **Rationale**: Las salidas 27.50, 30.00, 3.33 y 4.00 fijan el comportamiento observable; las estrategias mantienen aisladas las reglas de redondeo.
- **Alternatives considered**: Redondear el total antes de dividir; incompatible con la aceptación de 10.00 / 3.

## Decision: Errores de entrada

- **Decision**: La validación ocurre antes del cálculo; texto no numérico se traduce al error de campo requerido, los valores no válidos no conservan resultados anteriores.
- **Rationale**: El caso de cero personas exige un mensaje exacto y ningún resultado; separar validación del cálculo cumple SRP.
- **Alternatives considered**: Lanzar excepciones desde el cálculo; rechazada porque la interfaz necesita mensajes de campo y el cálculo no debe validar.
