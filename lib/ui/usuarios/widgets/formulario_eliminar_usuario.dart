import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/providers/usuario_provider.dart';

void mostrarDialogoEliminarUsuario(BuildContext context, int idUsuario) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Eliminar Usuario"),
      content: const Text("¿Estás segura de que deseas eliminar este usuario?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () async {
            final provider =
                Provider.of<UsuarioProvider>(context, listen: false);

            await provider.eliminarUsuario(idUsuario);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuario eliminado correctamente")),
            );

            Navigator.pop(context);
          },
          child: const Text("Eliminar"),
        ),
      ],
    ),
  );
}

