import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/clases.dart';

void mostraInfoClaseSeleccinada(BuildContext context, Clase clase) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Clase ID ${clase.idClase}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nombre: ${clase.nombreClase}"),
          Text("Horario: ${clase.horario?.toString() ?? 'No definido'}"),
          Text("Cupos: ${clase.cupos}"),
          Text("Descripción: ${clase.descripcion ?? 'Sin descripción'}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cerrar"),
        ),
      ],
    ),
  );
}
