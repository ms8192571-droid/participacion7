import 'package:flutter/material.dart';

import 'divisor_controller.dart';
import 'formateador_moneda.dart';

class PantallaDivisor extends StatefulWidget {
  final DivisorController controller;
  final FormateadorMoneda formateador;

  const PantallaDivisor({
    super.key,
    required this.controller,
    required this.formateador,
  });

  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _montoController = TextEditingController();
  final _personasController = TextEditingController();
  final _propinaController = TextEditingController(text: '0');
  String _modo = 'exacto';

  @override
  void dispose() {
    _montoController.dispose();
    _personasController.dispose();
    _propinaController.dispose();
    super.dispose();
  }

  void _calcular() {
    setState(() {
      widget.controller.calcular(
        monto: _montoController.text,
        personas: _personasController.text,
        propina: _propinaController.text,
        redondearHaciaArriba: _modo == 'arriba',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Divisor de cuenta')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: ListView(
            padding: const EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              const Text(
                '¿Cuánto paga cada persona?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                key: const ValueKey('monto'),
                controller: _montoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Monto total',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                key: const ValueKey('personas'),
                controller: _personasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número de personas',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                key: const ValueKey('propina'),
                controller: _propinaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Propina (%)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: const ValueKey('modo'),
                initialValue: _modo,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Modo de redondeo',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'exacto', child: Text('Exacto')),
                  DropdownMenuItem(
                    value: 'arriba',
                    child: Text('Hacia arriba al entero'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _modo = value);
                  }
                },
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _calcular,
                child: const Text('Calcular'),
              ),
              if (controller.error != null) ...[
                const SizedBox(height: 16),
                Text(
                  controller.error!,
                  key: const ValueKey('error'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              if (controller.resultado != null) ...[
                const SizedBox(height: 16),
                const Text('Cada persona paga:'),
                Text(
                  widget.formateador
                      .formatear(controller.resultado!.montoPorPersona),
                  key: const ValueKey('resultado'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
