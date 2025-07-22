import 'package:flutter/material.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:provider/provider.dart';
import 'mostrar_info_clase_seleccinada.dart';

void mostarDialogoObtenerClasePorId(BuildContext context) {
  final clasesProvider = Provider.of<ClasesProvider>(context, listen: false);
  final clases = clasesProvider.clases;

  int? claseSeleccionadaId;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Buscar clase por ID"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                    decoration:
                        const InputDecoration(labelText: "Seleccionar clase"),
                    items: clases.map((clase) {
                      return DropdownMenuItem<int>(
                        value: clase.idClase,
                        child:
                            Text("ID: ${clase.idClase}-${clase.nombreClase}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      claseSeleccionadaId = value;
                    }),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (claseSeleccionadaId != null) {
                      final clase = clases
                          .firstWhere((c) => c.idClase == claseSeleccionadaId);
                      Navigator.pop(context);
                      mostraInfoClaseSeleccinada(context, clase);
                    }
                  },
                  child: const Text("Ver detalles"),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
