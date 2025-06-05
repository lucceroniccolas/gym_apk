import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

void mostrarFormularioModificarUsuario(BuildContext context, Usuario usuario) {
  final nombreController = TextEditingController(
      text: usuario
          .nombre); // es un controlador que me permite leer el texto que escribio el usuario en el TextField
  final apellidoController = TextEditingController(text: usuario.apellido);
  final correoController = TextEditingController(text: usuario.correo);
}
