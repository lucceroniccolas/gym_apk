import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

void mostrarFormularioModificarUsuario(BuildContext context, Usuario usuario) {
  final _nombreController = TextEditingController(text: usuario.nombre);
  final _apellidoController = TextEditingController(text: usuario.apellido);
  final _correoController = TextEditingController(text: usuario.correo ?? '');
  bool _pago = usuario.pago;
  DateTime? _fechaSeleccionada = usuario.fechaDePago;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Modificar Usuario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                ),
                TextField(
                  controller: _correoController,
                  decoration:
                      const InputDecoration(labelText: 'Correo (opcional)'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("¿Pagó cuota?"),
                    Switch(
                      value: _pago,
                      onChanged: (value) {
                        setState(() {
                          _pago = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                        ? "Seleccionar fecha de pago"
                        : "Fecha: ${_fechaSeleccionada!.toLocal().toString().split(' ')[0]}",
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
                      Provider.of<UsuarioProvider>(context, listen: false);

                  final nombre = _nombreController.text.trim();
                  final apellido = _apellidoController.text.trim();
                  final correo = _correoController.text.trim();

                  if (nombre.isNotEmpty && apellido.isNotEmpty) {
                    final usuarioModificado = Usuario(
                      idUsuario: usuario.idUsuario,
                      nombre: nombre,
                      apellido: apellido,
                      correo: correo.isEmpty ? null : correo,
                      pago: _pago,
                      fechaDePago: _fechaSeleccionada,
                      // si quitás roles
                    );

                    await provider.modificarUsuario(usuarioModificado);
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
