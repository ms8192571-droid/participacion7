# Modelo de datos: Divisor de cuenta

## Cuenta

Entrada inmutable de un cálculo.

| Campo | Tipo | Regla |
|---|---|---|
| montoTotal | double | Finito y no negativo |
| personas | int | Entero mayor que cero |
| porcentajePropina | double | Finito y no negativo |

El texto de los campos se convierte en presentación. Si el monto no se puede convertir, la validación produce `Monto inválido`.

## Resultado

Salida inmutable de cálculo.

| Campo | Tipo | Regla |
|---|---|---|
| montoPorPersona | double | Importe individual después de aplicar la estrategia seleccionada |

## EstrategiaRedondeo

Abstracción del dominio con un único método que recibe el importe individual sin redondear y devuelve el importe redondeado. `RedondeoExacto` conserva dos decimales; `RedondeoHaciaArriba` aplica techo al entero. Ambos implementan el mismo contrato.

## Regla de cálculo

`totalConPropina = montoTotal * (1 + porcentajePropina / 100)`  
`importeIndividual = totalConPropina / personas`  
`montoPorPersona = estrategia.redondear(importeIndividual)`

`ValidarEntrada` revisa la cuenta antes de invocar el caso de uso. `CalcularDivision` no valida ni formatea.
