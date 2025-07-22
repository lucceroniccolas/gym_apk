import 'package:flutter/material.dart';
import 'package:gym_apk/ui/clases/formulario_obtener_clase_por_id.dart';
import 'package:provider/provider.dart';
import '../../providers/clases_provider.dart';

import 'formulario_crear_clase.dart';
import 'formulario_modificar_clase.dart';
import 'formulario_eliminar_clase.dart';

class ClasesView extends StatelessWidget {
  const ClasesView({super.key});

  @override
  Widget build(BuildContext context) {
    final clasesProvider = Provider.of<ClasesProvider>(context);
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
                        mostrarFormularioCrearClase(context);
                      },
                      child: const Text("Crear Clase"),
                    ),
                    ElevatedButton(
                      onPressed: claseSeleccionada == null
                          ? null
                          : () => mostrarDialogoEliminarClase(
                              context, claseSeleccionada.idClase),
                      child: const Text("Eliminar Clase"),
                    ),
                    ElevatedButton(
                      onPressed: claseSeleccionada == null
                          ? null
                          : () => mostrarFormularioModificarClase(
                              context, claseSeleccionada),
                      child: const Text("Modificar Clase"),
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
                      onPressed: () => mostarDialogoObtenerClasePorId(context),
                      child: const Text("Buscar clase por ID"),
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
