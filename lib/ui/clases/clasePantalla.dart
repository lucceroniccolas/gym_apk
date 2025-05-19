import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/clases_provider.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'widgets/formulario_crear_clase.dart';

class ClasesView extends StatelessWidget {
  const ClasesView({super.key});

  @override
  Widget build(BuildContext context) {
    final clasesProvider = Provider.of<ClasesProvider>(context);
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
                        subtitle: Text("ID: ${clase.idClase}"),
                      );
                    },
                  ),
                ),
                const Divider(),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        mostrarFormularioCrearClase(context);
                      },
                      child: const Text("Crear Clase"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Eliminar Clase"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Modificar Clase"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
