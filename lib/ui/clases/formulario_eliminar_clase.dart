import 'package:flutter/material.dart';

import 'package:gym_apk/providers/clases_provider.dart';
import 'package:provider/provider.dart';

void mostrarDialogoEliminarClase(BuildContext context, int idClase) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Eliminar Clase"),
      content: const Text("¿Estás seguro de que deseas eliminar esta clase?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () async {
            final provider = Provider.of<ClasesProvider>(context,
                listen:
                    false); //listen: false se usa para no redibujar la UI automáticamente si cambian los datos del provider.
            // Como no necesitás re-renderizar la pantalla al obtenerlo, lo pones en false.
            await provider.eliminarClase(idClase);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Clase eliminada correctamente")));
            Navigator.pop(context);
          },
          child: const Text("Eliminar"),
        ),
      ],
    ),
  );
}
