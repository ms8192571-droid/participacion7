# Tasks: Divisor de cuenta

**Input**: Design documents from `specs/001-divisor-cuenta/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `quickstart.md`

**Tests**: Required by the acceptance criteria and Constitution. Keep case data separate from test execution.

**Organization**: Tasks are grouped by user story and include exact paths.

## Phase 1: Setup

**Purpose**: Confirm the generated Flutter project is ready for implementation.

- [ ] T001 Verify `flutter pub get` succeeds without adding dependencies to `pubspec.yaml`.

## Phase 2: Foundational

**Purpose**: Create the domain contract and shared use cases required by all stories.

- [ ] T002 Create immutable `Cuenta` and `Resultado`, the single-method `EstrategiaRedondeo`, and the `ValidarEntrada` and `CalcularDivision` use cases in `lib/domain/cuenta.dart`, `lib/domain/resultado.dart`, `lib/domain/estrategia_redondeo.dart`, `lib/domain/validar_entrada.dart`, and `lib/domain/calcular_division.dart`.

**Checkpoint**: Domain types and validation/calculation contracts are ready; domain has no Flutter imports.

## Phase 3: User Story 1 - Calcular el reparto (Priority: P1)

**Goal**: Calculate an individual share including the tip and show it to two decimal places.

**Independent Test**: Run the exact-mode calculation scenarios and verify 27.50, 30.00 and 3.33.

### Tests for User Story 1

- [ ] T003 [P] [US1] Create the six literal acceptance inputs and expected outputs in `test/casos_de_prueba.dart`.
- [ ] T004 [US1] Add table-driven domain tests in `test/division_test.dart` that validate each case before calculation and compare valid results with `closeTo(esperado, 0.001)`.

### Implementation for User Story 1

- [ ] T005 [US1] Implement cent rounding in `lib/data/redondeo_exacto.dart`.
- [ ] T006 [US1] Implement injected calculation and input conversion in `lib/presentation/divisor_controller.dart`, two-decimal formatting in `lib/presentation/formateador_moneda.dart`, and the one-screen form in `lib/presentation/pantalla_divisor.dart`.
- [ ] T007 [US1] Compose the concrete data strategies and application in `lib/main.dart`.

**Checkpoint**: The exact-mode share is calculated locally and displayed with two decimals.

## Phase 4: User Story 3 - Recibir errores de entrada (Priority: P1)

**Goal**: Reject invalid input with the specified message and never leave a stale result visible.

**Independent Test**: Zero people show the exact message; a non-numeric amount shows `Monto inválido`; neither shows a result.

### Tests for User Story 3

- [ ] T008 [P] [US3] Add the three requested UI acceptance tests in `test/pantalla_test.dart` using `testWidgets`, `tester.enterText`, and exact text finders.

### Implementation for User Story 3

- [ ] T009 [US3] Complete finite/non-negative amount, positive-person, and non-negative-tip validation in `lib/domain/validar_entrada.dart`; show field errors and clear stale results in `lib/presentation/divisor_controller.dart` and `lib/presentation/pantalla_divisor.dart`.

**Checkpoint**: Invalid input displays its error and no individual amount.

## Phase 5: User Story 2 - Elegir redondeo (Priority: P2)

**Goal**: Select exact-to-cents or ceiling-to-integer rounding without type checks in the calculation use case.

**Independent Test**: The same calculation use case returns 3.33 with `RedondeoExacto` and 4.00 with `RedondeoHaciaArriba`.

### Tests for User Story 2

- [ ] T010 [US2] Add the LSP substitution test to `test/division_test.dart`, using one `CalcularDivision` instance with both strategies and no type check or cast.

### Implementation for User Story 2

- [ ] T011 [P] [US2] Implement ceiling-to-integer rounding in `lib/data/redondeo_hacia_arriba.dart`.
- [ ] T012 [US2] Wire the rounding selector through `lib/presentation/divisor_controller.dart` and `lib/presentation/pantalla_divisor.dart` without importing concrete data classes there.

**Checkpoint**: Both strategies use the same domain interface and can be selected in the screen.

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Verify acceptance, architecture, and build quality.

- [ ] T013 Run `flutter test`, `flutter test --reporter expanded`, and `flutter analyze`; fix implementation files rather than changing acceptance cases in `test/casos_de_prueba.dart`.
- [ ] T014 Verify the SOLID checks and attempt `flutter build apk --debug` using the commands in `specs/001-divisor-cuenta/quickstart.md`.

## Dependencies

- T001 precedes T002.
- T002 precedes all user-story tasks.
- T005-T007 precede the UI tests in T008.
- T005-T007 precede T011-T012.
- T003-T004 cover the six acceptance fixtures and domain test runner.
- T013-T014 follow all story implementation and tests.

## Parallel Opportunities

- T003 can be prepared independently of source implementation.
- T005, T006, and T011 can be developed in separate files after T002; T012 integrates both strategies into presentation.
- T008 is a separate test file and can be authored alongside domain tests.

## Implementation Strategy

Complete the domain foundation first, then deliver the exact-mode single-screen MVP (US1), validation/error behavior (US3), and the interchangeable upward strategy (US2). Finish by running the full test, analyzer, architecture, and Android build checks.
