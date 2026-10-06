# Constitución del divisor de cuenta

## Principios fundamentales

### SRP — Responsabilidad única
Cada clase tiene una sola razón para cambiar. El cálculo no valida entradas ni formatea resultados; cada responsabilidad vive en su propio componente.

### OCP — Abierto/cerrado
Se puede agregar una estrategia de redondeo creando otra implementación de `EstrategiaRedondeo`, sin editar las estrategias existentes ni `CalcularDivision`.

### LSP — Sustitución de Liskov
Cualquier implementación de `EstrategiaRedondeo` puede sustituir a otra en `CalcularDivision`; quien la usa no pregunta el tipo ni realiza casts.

### ISP — Segregación de interfaces
`EstrategiaRedondeo` expone un único método para redondear el importe individual; los clientes no dependen de operaciones que no utilizan.

### DIP — Inversión de dependencias
La presentación depende de abstracciones del dominio y nunca de clases concretas de datos. `main.dart` es el único punto que instancia implementaciones concretas.

## Arquitectura y restricciones

- Capas: `presentation`, `domain` y `data`, con dependencias `presentation -> domain <- data`.
- `lib/domain/` usa Dart puro y no importa `package:flutter`.
- La aplicación tiene una sola pantalla, funciona sin red ni base de datos, usa Flutter estable y no agrega paquetes externos.
- Se aplica null safety y se usan nombres en español.
- No se guardan secretos ni API keys en el repositorio.

## Calidad y pruebas

- Toda funcionalidad crítica tiene pruebas.
- Cada criterio de aceptación de la especificación tiene una prueba ejecutable.
- Toda función generada debe poder ser explicada por el estudiante: propósito, entradas, salida y errores.

## Gobierno

Esta constitución rige la especificación, el plan, las tareas, la implementación y sus pruebas. Una excepción requiere actualizar primero esta constitución y justificar el cambio.

**Versión**: 1.0.0 | **Ratificada**: 2026-10-06 | **Última modificación**: 2026-10-06
