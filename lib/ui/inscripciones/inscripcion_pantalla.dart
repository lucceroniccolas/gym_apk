import 'package:flutter/material.dart';

import 'widgets/boton_accion.dart';

class InscripcionView extends StatelessWidget {
  const InscripcionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Inscripciones"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotonAccion(
              texto: "Inscribir alumno",
              onPressed: () {
                Navigator.pushNamed(context, "/inscribirAlumno");
              },
            ),
            const SizedBox(height: 16),
            BotonAccion(
              texto: "Cancelar inscripcion",
              onPressed: () {
                Navigator.pushNamed(context, "/cancelarInscripcion");
              },
            ),
            const SizedBox(height: 16),
            BotonAccion(
              texto: "Mostrar inscriptos de una clase",
              onPressed: () {
                Navigator.pushNamed(context, "/mostarInscriptos");
              },
            ),
            const SizedBox(height: 16),
            BotonAccion(
              texto: "Mostrar clase inscriptas de un usuario",
              onPressed: () {
                Navigator.pushNamed(context, "/mostrarClasesInscriptas");
              },
            ),
          ],
        ),
      ),
    );
  }
}
