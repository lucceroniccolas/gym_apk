import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:provider/provider.dart';

void mostrarFormularioCrearClase(BuildContext context) {
  final _nombreController = TextEditingController();
  DateTime? _fechaSeleccionada;
  final _descripcionController = TextEditingController();
  final _cuposController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Crear Clase'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration:
                      const InputDecoration(labelText: 'Nombre de la clase'),
                ),
                TextField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(
                      labelText: "Descripcion de la clase"),
                ),
                TextField(
                  controller: _cuposController,
                  decoration: const InputDecoration(labelText: "Cupos"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (fecha != null) {
                      setState(() {
                        _fechaSeleccionada = fecha;
                      });
                    }
                  },
                  child: Text(
                    _fechaSeleccionada == null
                        ? "Seleccionar fecha"
                        : "Fecha: ${_fechaSeleccionada!.toLocal()}"
                            .split(' ')[0],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final provider =
                      Provider.of<ClasesProvider>(context, listen: false);

                  final nombre = _nombreController.text.trim();
                  final descripcion = _descripcionController.text.trim();
                  final cupos = int.tryParse(_cuposController.text);

                  if (nombre.isNotEmpty &&
                      _fechaSeleccionada != null &&
                      descripcion.isNotEmpty &&
                      cupos != null) {
                    final nuevaClase = Clase(
                      idClase: 0,
                      nombreClase: nombre,
                      cupos: cupos,
                      horario: _fechaSeleccionada!,
                      descripcion: descripcion,
                    );
                    await provider.crearClase(nuevaClase);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );
}
