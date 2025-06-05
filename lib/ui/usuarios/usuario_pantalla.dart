import 'package:flutter/material.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:gym_apk/ui/clases/widgets/formulario_obtener_clase_por_id.dart';
import 'package:provider/provider.dart';
import '../../providers/clases_provider.dart';

import '../clases/widgets/formulario_crear_clase.dart';
import '../clases/widgets/formulario_modificar_clase.dart';
import '../clases/widgets/formulario_eliminar_clase.dart';

class UsuariosView extends StatelessWidget {
  const UsuariosView({super.key});

  @override
  Widget build(BuildContext context) {
    final usuariosProvider = Provider.of<UsuarioProvider>(context);
    final usuarioSeleccionada = usuariosProvider.usuarioSeleccionado;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion de Usuarios"),
      ),
      body: usuariosProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: usuariosProvider.usuarios.length,
                    itemBuilder: (context, index) {
                      final usuario = usuariosProvider.usuarios[index];
                      return ListTile(
                        title: Text(usuario.nombre),
                        subtitle: Text(usuario.apellido),
                        trailing: Text(
                          usuario.pago.toString(),
                        ),
                        selected:
                            usuarioSeleccionada?.idUsuario == usuario.idUsuario,
                        onTap: () {
                          usuariosProvider.usuarioSeleccionado = usuario;
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
                        mostrarFormularioCrearClase(context);
                      },
                      child: const Text("Crear Clase"),
                    ),
                    ElevatedButton(
                      onPressed: usuarioSeleccionada == null
                          ? null
                          : () => mostrarDialogoEliminarClase(
                              context, usuarioSeleccionada.idUsuario),
                      child: const Text("Eliminar Clase"),
                    ),
                    ElevatedButton(
                      onPressed: usuarioSeleccionada == null
                          ? null
                          : () => mostrarFormularioModificarClase(
                              context, usuarioSeleccionada),
                      child: const Text("Modificar Clase"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (usuarioSeleccionada != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Usuario seleccionado: ${usuarioSeleccionada.nombre}"),
                            ),
                          );
                        }
                      },
                      child: const Text("Usuario seleccionado"),
                    ),
                    ElevatedButton(
                      onPressed: () => mostarDialogoObtenerClasePorId(context),
                      child: const Text("Detalles de Usuario"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
    );
  }
}
