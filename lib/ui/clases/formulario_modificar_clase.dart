import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:provider/provider.dart';

void mostrarFormularioModificarClase(BuildContext context, Clase clase) {
  final _nombreController = TextEditingController(text: clase.nombreClase);
  DateTime? _fechaSeleccionada = clase.horario;
  final _descripcionController = TextEditingController(text: clase.descripcion);

  final _cuposController = TextEditingController(text: clase.cupos.toString());

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Modificar Clase'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration:
                      const InputDecoration(labelText: 'Nombre de la clase'),
                ),
                TextField(
                  controller: _cuposController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Cupos"),
                ),
                TextField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(labelText: "Descripción"),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: _fechaSeleccionada ?? DateTime.now(),
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

                  final cupos = int.tryParse(_cuposController.text.trim());

                  if (nombre.isNotEmpty &&
                      descripcion.isNotEmpty &&
                      _fechaSeleccionada != null &&
                      cupos != null) {
                    final claseModificada = clase.copyWith(
                        nombreClase: nombre,
                        descripcion: descripcion,
                        horario: _fechaSeleccionada,
                        cupos: cupos);

                    await provider.modificarClase(
                        clase.idClase, claseModificada);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          );
        },
      );
    },
  );
}
