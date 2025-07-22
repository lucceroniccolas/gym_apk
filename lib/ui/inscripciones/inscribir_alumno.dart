import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'widgets/boton_accion.dart';

class InscribirAlumnoView extends StatefulWidget {
  const InscribirAlumnoView({super.key});
  @override
  State<InscribirAlumnoView> createState() => _InscribirAlumnoViewState();
}

class _InscribirAlumnoViewState extends State<InscribirAlumnoView> {
  Usuario? _usuarioSeleccionado;
  Clase? _claseSeleccionada;
  String _filtro = "";
  @override
  void initState() {
    super.initState();

//¿Qué hace esto?
    Future.delayed(Duration.zero, () {
      //esperás un micro momento después del build, entonces ya no estás dentro de la fase de construcción y
      // es seguro llamar a notifyListeners(). (notifyListeners está dentro de la función)

      Provider.of<UsuarioProvider>(context, listen: false).cargarUsuarios();

      Provider.of<ClasesProvider>(context, listen: false).obtenerClases();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuariosProvider = Provider.of<UsuarioProvider>(context);
    final clasesProvider = Provider.of<ClasesProvider>(context);
    final inscripcionProvider = Provider.of<InscripcionProvider>(context);
    final usuariosFiltrados = usuariosProvider.usuarios.where((usuario) {
      return usuario.nombre.toLowerCase().contains(_filtro.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Inscribir Alumno a Clase")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(labelText: "buscar alumno por nombre"),
              onChanged: (value) => setState(() => _filtro = value),
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButton<Usuario>(
              isExpanded: true,
              value: _usuarioSeleccionado,
              hint: const Text("Seleccionar alumno"),
              items: usuariosFiltrados.map((usuario) {
                return DropdownMenuItem(
                  value: usuario,
                  child: Text(usuario.nombre),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _usuarioSeleccionado = value);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButton<Clase>(
              isExpanded: true,
              value: _claseSeleccionada,
              hint: const Text("Seleccionar clase"),
              items: clasesProvider.clases.map((clase) {
                return DropdownMenuItem(
                  value: clase,
                  child: Text("${clase.nombreClase} (Cupos: ${clase.cupos})"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _claseSeleccionada = value);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            BotonAccion(
                texto: "Incribir",
                onPressed: () async {
                  if (_usuarioSeleccionado == null ||
                      _claseSeleccionada == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Debe seleccionar un alumno y una clase")),
                    );
                    return;
                  }
                  final resultado =
                      await inscripcionProvider.inscribirAlumnoAClase(
                    _usuarioSeleccionado!.idUsuario,
                    _claseSeleccionada!.idClase,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(resultado
                          ? "Alumno Inscripto correctamente"
                          : "No se pudo inscribir al alumno"),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
