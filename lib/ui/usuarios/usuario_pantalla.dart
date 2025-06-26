import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/providers/usuario_provider.dart';

import 'widgets/formulario_crear_usuario.dart';
import 'widgets/formulario_modificar_usuario.dart';
import 'widgets/formulario_eliminar_usuario.dart';
import 'widgets/formulario_mostrar_usuario_por_id.dart';

class UsuariosView extends StatelessWidget {
  const UsuariosView({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuarioSeleccionado = usuarioProvider.usuarioSeleccionado;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Usuarios"),
      ),
      body: usuarioProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: usuarioProvider.usuarios.length,
                    itemBuilder: (context, index) {
                      final usuario = usuarioProvider.usuarios[index];
                      return ListTile(
                        title: Text("${usuario.nombre} ${usuario.apellido}"),
                        subtitle: Text(usuario.correo ?? "Sin correo"),
                        trailing: Text(usuario.pago ? "Pagó" : "No pagó"),
                        selected: usuarioSeleccionado?.idUsuario == usuario.idUsuario,
                        onTap: () {
                          usuarioProvider.usuarioSeleccionado = usuario;
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        mostrarFormularioCrearUsuario(context);
                      },
                      child: const Text("Crear Usuario"),
                    ),
                    ElevatedButton(
                      onPressed: usuarioSeleccionado == null
                          ? null
                          : () => mostrarDialogoEliminarUsuario(
                              context, usuarioSeleccionado.idUsuario),
                      child: const Text("Eliminar Usuario"),
                    ),
                    ElevatedButton(
                      onPressed: usuarioSeleccionado == null
                          ? null
                          : () => mostrarFormularioModificarUsuario(
                              context, usuarioSeleccionado),
                      child: const Text("Modificar Usuario"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (usuarioSeleccionado != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Usuario seleccionado: ${usuarioSeleccionado.nombre}"),
                            ),
                          );
                        }
                      },
                      child: const Text("Usuario seleccionado"),
                    ),
                    ElevatedButton(
                      onPressed: () => mostrarDialogoObtenerUsuarioPorId(context),
                      child: const Text("Buscar usuario por ID"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
