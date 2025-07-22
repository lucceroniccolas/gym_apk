import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';

class CancelarInscripcionView extends StatelessWidget {
  const CancelarInscripcionView({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InscripcionProvider>(context);
    final inscripciones = provider.inscripcionesDetalladas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cancelar Inscripciones"),
      ),
      body: ListView.builder(
        itemCount: inscripciones.length,
        itemBuilder: (context, index) {
          final insc = inscripciones[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(insc.nombreUsuario),
              subtitle: Text("${insc.nombreClase} - ${insc.fechaInscripcion}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Confirmar"),
                      content: const Text("Cancelar esta inscripcion?"),
                      actions: [
                        TextButton(
                          child: const Text("No"),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          child: const Text("Si"),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await provider.cancelarInscripcion(
                        insc.idUsuario, insc.idClase);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Inscripcion cancelada ")),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
