import 'package:flutter/material.dart';

import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';

class MostrarClaseInscriptaAlumnoView extends StatefulWidget {
  const MostrarClaseInscriptaAlumnoView({super.key});
  @override
  State<MostrarClaseInscriptaAlumnoView> createState() =>
      _MostrarClaseInscriptaAlumnoViewState();
}

class _MostrarClaseInscriptaAlumnoViewState
    extends State<MostrarClaseInscriptaAlumnoView> {
  Usuario? _usuarioSeleccionado;
  List<Clase> _clasesInscriptas = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<UsuarioProvider>(context, listen: false).cargarUsuarios();
      },
    );
  }

  Future<void> _buscarClases() async {
    if (_usuarioSeleccionado == null) return;
    final inscripcionProvider =
        Provider.of<InscripcionProvider>(context, listen: false);
    await inscripcionProvider
        .obtenerInscripcionesDeUsuario(_usuarioSeleccionado!.idUsuario);

    setState(() {
      _clasesInscriptas = inscripcionProvider.inscripcionesUsuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuarios = usuarioProvider.usuarios;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clases inscriptas de usuario"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DropdownButtonFormField<Usuario>(
                decoration:
                    const InputDecoration(labelText: "Seleccionar usuario"),
                value: _usuarioSeleccionado,
                items: usuarios.map((usuario) {
                  return DropdownMenuItem(
                    value: usuario,
                    child: Text(usuario.nombre),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _usuarioSeleccionado = value;
                  });
                  _buscarClases();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _clasesInscriptas.isEmpty
                    ? const Center(
                        child: Text("No hay inscripciones a clases"),
                      )
                    : ListView.builder(
                        itemCount: _clasesInscriptas.length,
                        itemBuilder: (_, index) {
                          final clase = _clasesInscriptas[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(clase.nombreClase),
                              subtitle:
                                  Text("Descripcion: ${clase.descripcion}"),
                            ),
                          );
                        },
                      ),
              )
            ],
          )),
    );
  }
}
