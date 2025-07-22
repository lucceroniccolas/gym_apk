import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:gym_apk/providers/usuario_provider.dart';
import 'package:gym_apk/providers/inscripcion_provider.dart';
import 'package:gym_apk/routes/app_routes.dart';

import 'clases/clase_pantalla.dart';
import 'usuarios/usuario_pantalla.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    // Esperamos a que el widget esté completamente montado
    Future.delayed(Duration.zero, () {
      Provider.of<ClasesProvider>(context, listen: false).obtenerClases();
      Provider.of<UsuarioProvider>(context, listen: false).cargarUsuarios();
      Provider.of<InscripcionProvider>(context, listen: false).cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú Principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.fitness_center),
              label: const Text("Clases"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ClasesView()),
                );
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.paste_outlined),
              label: const Text("Incripciones"),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.gestionInscripciones);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text("Usuarios"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UsuariosView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
