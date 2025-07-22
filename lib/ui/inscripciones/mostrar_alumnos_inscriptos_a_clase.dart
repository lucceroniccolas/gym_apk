import 'package:flutter/material.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';

class MostrarInscriptosView extends StatefulWidget {
  const MostrarInscriptosView({super.key});
  @override
  State<MostrarInscriptosView> createState() => _MostrarInscriptosViewState();
}

class _MostrarInscriptosViewState extends State<MostrarInscriptosView> {
  Clase? _claseSeleccionada;
  List<Usuario> _usuariosInscriptos = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<ClasesProvider>(context, listen: false).obtenerClases();
      },
    );
  }

  Future<void> _buscarInscriptos() async {
    if (_claseSeleccionada == null) return;
    final inscripcionProvider =
        Provider.of<InscripcionProvider>(context, listen: false);
    await inscripcionProvider //este metodo no devuelve nada solo carga datos internos en el provider
        .obtenerInscriptosDeClase(_claseSeleccionada!.idClase);

    setState(() {
      _usuariosInscriptos = inscripcionProvider.inscriptosEnClase;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clasesProvider = Provider.of<ClasesProvider>(context);
    final clases = clasesProvider.clases;
    return Scaffold(
      appBar: AppBar(title: const Text("Incriptos en clase")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Clase>(
              decoration: const InputDecoration(labelText: "Seleccionar clase"),
              value: _claseSeleccionada,
              items: clases.map((clase) {
                return DropdownMenuItem(
                  value: clase,
                  child: Text(clase.nombreClase),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _claseSeleccionada = value;
                });
                _buscarInscriptos();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _usuariosInscriptos.isEmpty
                  ? const Center(child: Text("No hay usuarios inscriptos"))
                  : ListView.builder(
                      itemCount: _usuariosInscriptos.length,
                      itemBuilder: (_, index) {
                        final usuario = _usuariosInscriptos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(usuario.nombre),
                            subtitle: Text("ID: ${usuario.idUsuario}"),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
