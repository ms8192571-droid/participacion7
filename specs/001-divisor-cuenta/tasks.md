# Tasks: Divisor de cuenta

**Input**: Design documents from `specs/001-divisor-cuenta/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `quickstart.md`

**Tests**: Required by the acceptance criteria and Constitution. Keep case data separate from test execution.

**Organization**: Tasks are grouped by user story and include exact paths. All listed tasks are complete.

## Phase 1: Setup

**Purpose**: Confirm the generated Flutter project is ready for implementation.

- [x] T001 Verify `flutter pub get` succeeds without adding dependencies to `pubspec.yaml`.

## Phase 2: Foundational

**Purpose**: Create the domain contract and shared use cases required by all stories.

- [x] T002 Create immutable `Cuenta` and `Resultado`, the single-method `EstrategiaRedondeo`, and the `ValidarEntrada` and `CalcularDivision` use cases in `lib/domain/cuenta.dart`, `lib/domain/resultado.dart`, `lib/domain/estrategia_redondeo.dart`, `lib/domain/validar_entrada.dart`, and `lib/domain/calcular_division.dart`.

**Checkpoint**: Domain types and validation/calculation contracts are ready; domain has no Flutter imports.

## Phase 3: User Story 1 - Calcular el reparto (Priority: P1)

**Goal**: Calculate an individual share including the tip and show it to two decimal places.

**Independent Test**: Run exact-mode scenarios and verify 27.50, 30.00 and 3.33.

### Implementation for User Story 1

- [x] T003 [P] [US1] Create the six literal acceptance inputs and expected outputs in `test/casos_de_prueba.dart`.
- [x] T004 [US1] Implement cent rounding in `lib/data/redondeo_exacto.dart`.
- [x] T005 [US1] Implement injected calculation and exact-mode input conversion in `lib/presentation/divisor_controller.dart`, two-decimal formatting in `lib/presentation/formateador_moneda.dart`, and the one-screen form in `lib/presentation/pantalla_divisor.dart`.
- [x] T006 [US1] Compose the exact-mode application in `lib/main.dart`.

**Checkpoint**: The exact-mode share is calculated locally and displayed with two decimals.

## Phase 4: User Story 3 - Recibir errores de entrada (Priority: P1)

**Goal**: Reject invalid input with the specified message and never leave a stale result visible.

**Independent Test**: Zero people show the exact message; a non-numeric amount shows `Monto inválido`; neither shows a result.

### Implementation and Tests for User Story 3

- [x] T007 [US3] Complete finite/non-negative amount, positive-person, and non-negative-tip validation in `lib/domain/validar_entrada.dart`; show field errors and clear stale results in `lib/presentation/divisor_controller.dart` and `lib/presentation/pantalla_divisor.dart`.
- [x] T008 [P] [US3] Add the three requested UI acceptance tests in `test/pantalla_test.dart` using `testWidgets`, `tester.enterText`, and exact text finders.

**Checkpoint**: Invalid input displays its error and no individual amount.

## Phase 5: User Story 2 - Elegir redondeo (Priority: P2)

**Goal**: Select exact-to-cents or ceiling-to-integer rounding without type checks in the calculation use case.

**Independent Test**: The same calculation use case returns 3.33 with `RedondeoExacto` and 4.00 with `RedondeoHaciaArriba`.

### Implementation and Tests for User Story 2

- [x] T009 [P] [US2] Implement ceiling-to-integer rounding in `lib/data/redondeo_hacia_arriba.dart`.
- [x] T010 [US2] Wire the rounding selector through `lib/presentation/divisor_controller.dart` and `lib/presentation/pantalla_divisor.dart`, and compose both strategies in `lib/main.dart` without importing concrete data classes in presentation.
- [x] T011 [US2] Add `test/division_test.dart` to loop over the acceptance fixtures, validate before calculation, compare valid results with `closeTo(esperado, 0.001)`, and prove that the same `CalcularDivision` accepts both strategies without a type check or cast.

**Checkpoint**: Both strategies use the same domain interface and can be selected in the screen.

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Verify acceptance, architecture, and build quality.

- [x] T012 Run `flutter test`, `flutter test --reporter expanded`, and `flutter analyze`; keep acceptance cases in `test/casos_de_prueba.dart`.
- [x] T013 Verify the SOLID checks and attempt `flutter build apk --debug` using the commands in `specs/001-divisor-cuenta/quickstart.md`.

## Dependencies

- T001 precedes T002.
- T002 precedes all user-story tasks.
- T003-T006 establish the exact-mode MVP.
- T007-T008 depend on the screen and controller from T005.
- T009-T011 add the second strategy and its tests after the MVP.
- T012-T013 follow all story implementation and tests.

## Parallel Opportunities

- T003 can be prepared independently of source implementation.
- T004 and T007 touch separate domain/data files after T002.
- T008 is a separate widget-test file and can be authored alongside domain tests.

## Implementation Strategy

Complete the domain foundation first, then deliver the exact-mode single-screen MVP (US1), validation/error behavior (US3), and the interchangeable upward strategy (US2). Finish by running the full test, analyzer, architecture, and Android build checks.
