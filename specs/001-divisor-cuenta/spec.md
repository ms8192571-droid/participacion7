# Feature Specification: Divisor de cuenta

**Feature Branch**: `sdd`

**Created**: 2026-10-06

**Status**: Draft

**Input**: User description: "Una app de una sola pantalla para dividir la cuenta de un restaurante entre varias personas."

## User Scenarios & Testing

### User Story 1 - Calcular el reparto (Priority: P1)

Como comensal, ingreso el monto total, el número de personas y el porcentaje de propina, elijo el modo de redondeo y veo cuánto paga cada persona.

**Why this priority**: Es la necesidad principal que hace útil la aplicación.

**Independent Test**: Ingresar un monto, cantidad de personas y propina, calcular y comprobar el importe individual.

**Acceptance Scenarios**:

1. **Given** un total de 100.00, 4 personas y propina de 10%, **When** calculo en modo exacto, **Then** veo 27.50 por persona.
2. **Given** un total de 90.00, 3 personas y propina de 0%, **When** calculo en modo exacto, **Then** veo 30.00 por persona.
3. **Given** un total de 10.00, 3 personas y propina de 0%, **When** calculo en modo exacto, **Then** veo 3.33 por persona.

### User Story 2 - Elegir redondeo (Priority: P2)

Como comensal, elijo entre el reparto a centavos y redondear el importe individual hacia arriba al entero siguiente.

**Why this priority**: Permite elegir cómo resolver fracciones de moneda sin cambiar el reparto base.

**Independent Test**: Calcular 10.00 entre 3 personas sin propina con cada estrategia y comprobar 3.33 y 4.00, respectivamente.

**Acceptance Scenarios**:

1. **Given** un total de 10.00, 3 personas y propina de 0%, **When** calculo redondeando hacia arriba, **Then** veo 4.00 por persona.

### User Story 3 - Recibir errores de entrada (Priority: P1)

Como comensal, recibo un mensaje claro si el monto no es válido o no hay personas para dividir, y no veo un resultado inválido.

**Why this priority**: Evita mostrar una división incorrecta y hace comprensible la corrección necesaria.

**Independent Test**: Enviar un monto no numérico o cero personas y verificar el mensaje exacto y la ausencia de resultado.

**Acceptance Scenarios**:

1. **Given** un total de 50.00 y 0 personas, **When** calculo, **Then** veo "Debe haber al menos una persona" y no se muestra resultado.
2. **Given** el monto de entrada "abc", **When** calculo, **Then** veo "Monto inválido".

### Edge Cases

- Cero personas produce el mensaje exacto de aceptación y no deja visible un resultado anterior.
- Un monto no numérico, no finito o negativo se rechaza como "Monto inválido".
- Un número de personas que no sea un entero positivo se rechaza y no produce resultado.
- Una propina que no sea numérica, finita o no negativa se rechaza y no produce resultado.
- Si el importe individual ya es entero, el redondeo hacia arriba lo conserva.

## Requirements

### Functional Requirements

- **FR-001**: La aplicación MUST presentar una sola pantalla para ingresar monto total, personas y porcentaje de propina.
- **FR-002**: La aplicación MUST calcular el total con propina y dividirlo entre el número de personas.
- **FR-003**: La aplicación MUST permitir seleccionar redondeo a dos decimales o hacia arriba al entero.
- **FR-004**: La aplicación MUST mostrar el importe por persona con dos decimales.
- **FR-005**: La aplicación MUST mostrar "Debe haber al menos una persona" si el número de personas es cero y no mostrar resultado.
- **FR-006**: La aplicación MUST mostrar "Monto inválido" si el monto no se puede interpretar como importe válido.
- **FR-007**: La aplicación MUST aceptar entradas numéricas válidas de monto, personas y propina, y rechazar valores negativos; personas debe ser un entero positivo.
- **FR-008**: La aplicación MUST funcionar sin conexión a internet y sin base de datos.
- **FR-009**: La aplicación MUST retirar el resultado previo cuando un nuevo cálculo no es válido.

### Key Entities

- **Cuenta**: Monto total, número entero de personas y porcentaje de propina ingresados para un cálculo.
- **Resultado**: Importe individual calculado y redondeado para la cuenta.
- **Estrategia de redondeo**: Regla sustituible que transforma el importe individual antes de mostrarlo.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Los seis escenarios de aceptación producen el resultado o mensaje especificado.
- **SC-002**: Todo resultado visible contiene exactamente dos cifras decimales.
- **SC-003**: Ningún escenario con entradas no válidas presenta un resultado.
- **SC-004**: Las pruebas de dominio se ejecutan sin cargar widgets ni depender de Flutter.
- **SC-005**: La aplicación completa el cálculo localmente sin solicitudes de red ni almacenamiento persistente.

## Assumptions

- "Modo exacto" conserva precisión monetaria de dos decimales; por eso 10.00 / 3 se muestra como 3.33.
- "Hacia arriba al entero más cercano" significa redondear el importe individual hacia el siguiente entero (techo), conservando un entero si ya lo es.
- Los montos y el porcentaje de propina son no negativos; personas debe ser un entero positivo.
- No se necesita guardar cuentas ni mantener historial; los datos viven únicamente durante el uso de la pantalla.
- La interfaz y los mensajes están en español.
