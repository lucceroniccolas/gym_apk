import 'package:flutter/material.dart';
import 'package:gym_apk/providers/usuario_provider.dart';

import 'package:provider/provider.dart';
import 'formulario_mostrar_usuario_seleccionado.dart';

void mostrarDialogoObtenerUsuarioPorId(BuildContext context) {
  final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
  final usuarios = usuarioProvider.usuarios;

  int? usuarioSeleccionadoId;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Buscar usuario por ID"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  decoration:
                      const InputDecoration(labelText: "Seleccionar usuario"),
                  items: usuarios.map((usuario) {
                    return DropdownMenuItem<int>(
                      value: usuario.idUsuario,
                      child:
                          Text("ID: ${usuario.idUsuario} - ${usuario.nombre}"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      usuarioSeleccionadoId = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (usuarioSeleccionadoId != null) {
                      final usuario = usuarios.firstWhere(
                          (u) => u.idUsuario == usuarioSeleccionadoId);
                      Navigator.pop(context);
                      mostrarUsuarioSeleccionado(context, usuario);
                    }
                  },
                  child: const Text("Ver detalles"),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
