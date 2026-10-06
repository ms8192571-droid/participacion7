# Implementation Plan: Divisor de cuenta

**Branch**: `sdd` | **Date**: 2026-10-06 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification in `specs/001-divisor-cuenta/spec.md`.

## Summary

Construir una pantalla offline que calcula y muestra el pago individual con propina. Se separan validación, cálculo, estrategias sustituibles de redondeo, presentación y composición; `setState` conserva el estado local de esta única pantalla.

## Technical Context

**Language/Version**: Dart 3.13.2, Flutter 3.47.2 stable  
**Primary Dependencies**: Flutter SDK only; no third-party packages  
**Storage**: None; state remains in memory while the screen is open  
**Testing**: `flutter_test`; pure Dart domain tests and Flutter widget tests  
**Target Platform**: Flutter mobile app; Android debug build is a required check  
**Project Type**: Single Flutter application  
**Performance Goals**: Compute and show a result synchronously on button press  
**Constraints**: Offline, one screen, `setState`, null safety, Spanish identifiers, no package additions, no Flutter imports in `lib/domain/`  
**Scale/Scope**: One calculation flow, two rounding strategies, three layers and six acceptance scenarios

## Constitution Check

*GATE: checked before and after design.*

- [x] SRP: validation, calculation, rounding, formatting and rendering are separate.
- [x] OCP: adding a rounding rule uses a new `EstrategiaRedondeo` implementation.
- [x] LSP: the calculation accepts either strategy through the same contract, without type checks.
- [x] ISP: the rounding contract has one method.
- [x] DIP: presentation imports domain abstractions; only `main.dart` constructs data implementations.
- [x] Domain is pure Dart; no external packages, network or database are planned.
- [x] All acceptance scenarios receive automated domain or widget tests.
- [x] Every generated function and error path remains small enough to explain.

## Project Structure

### Documentation (this feature)

```text
specs/001-divisor-cuenta/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── tasks.md
```

### Source Code (repository root)

```text
lib/
├── domain/
│   ├── cuenta.dart
│   ├── resultado.dart
│   ├── estrategia_redondeo.dart
│   ├── calcular_division.dart
│   └── validar_entrada.dart
├── data/
│   ├── redondeo_exacto.dart
│   └── redondeo_hacia_arriba.dart
├── presentation/
│   ├── divisor_controller.dart
│   ├── formateador_moneda.dart
│   └── pantalla_divisor.dart
└── main.dart

test/
├── casos_de_prueba.dart
├── division_test.dart
└── pantalla_test.dart
```

**Structure Decision**: Aplicación Flutter única con las capas solicitadas. `presentation` depende de `domain`; `data` implementa la abstracción de redondeo de `domain`; `main.dart` realiza la composición. Las pruebas de dominio no cargan widgets.

## Complexity Tracking

No hay violaciones de la constitución ni complejidad adicional que justificar.
