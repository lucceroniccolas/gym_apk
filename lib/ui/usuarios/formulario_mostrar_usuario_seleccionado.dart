import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/usuario.dart';

void mostrarUsuarioSeleccionado(BuildContext context, Usuario usuario) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("${usuario.nombre} ${usuario.apellido}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (usuario.correo != null) Text("Correo: ${usuario.correo}"),
          Text("Pagó cuota: ${usuario.pago ? 'Sí' : 'No'}"),
          if (usuario.fechaDePago != null)
            Text(
                "Fecha de pago: ${usuario.fechaDePago!.toLocal().toString().split(' ')[0]}"),
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
