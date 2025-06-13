import 'package:flutter/material.dart';
import 'package:gym_apk/ui/inscripciones/widgets/cancelar_inscripcion.dart';
import 'package:gym_apk/ui/inscripciones/widgets/inscribir_alumno.dart';
import 'package:gym_apk/ui/inscripciones/widgets/mostrar_alumnos_inscriptos_a_clase.dart';
import 'package:gym_apk/ui/inscripciones/widgets/mostrar_clases_inscriptas_del_alumno.dart';
import 'package:provider/provider.dart';
import '../../providers/inscripcion_provider.dart';

class ClasesView extends StatelessWidget {
  const ClasesView({super.key});

  @override
  Widget build(BuildContext context) {
    final inscripcionProvider = Provider.of<InscripcionProvider>(context);
    final claseSeleccionada = clasesProvider.claseSeleccionada;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion de Clases"),
      ),
      body: clasesProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: clasesProvider.clases.length,
                    itemBuilder: (context, index) {
                      final clase = clasesProvider.clases[index];
                      return ListTile(
                        title: Text(clase.nombreClase),
                        subtitle: Text(clase.descripcion ?? "Sin descripcion"),
                        trailing: Text(
                          clase.horario?.toString() ?? "Sin horario",
                        ),
                        selected: claseSeleccionada?.idClase == clase.idClase,
                        onTap: () {
                          clasesProvider.claseSeleccionada = clase;
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
                        inscribirAlumno(context);
                      },
                      child: const Text("Inscribir alumno a clase"),
                    ),
                    ElevatedButton(
                      onPressed: claseSeleccionada == null
                          ? null
                          : () => cancelarInscripcion(
                              context, claseSeleccionada.idClase),
                      child: const Text("cancelar inscripcion"),
                    ),
                    ElevatedButton(
                      onPressed: claseSeleccionada == null
                          ? null
                          : () => mostrarAlumnoIncriptoClase(
                              context, claseSeleccionada),
                      child: const Text("Mostrar alumnos inscriptos a clase"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (claseSeleccionada != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Clase seleccionada: ${claseSeleccionada.nombreClase}"),
                            ),
                          );
                        }
                      },
                      child: const Text("Clase seleccionada"),
                    ),
                    ElevatedButton(
                      onPressed: () => mostrarClaseInscriptaAlumno(context),
                      child: const Text("Mostrar clases inscriptas del alumno"),
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
