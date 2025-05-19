import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/clases_provider.dart';
import 'ui/homePage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ClasesProvider(
                _crearClase,
                _eliminarClase,
                _modificarClase,
                _obtenerClasePorId,
                _obtenerHorarioPorIdDeClase,
                _obtenerTodasLasClases)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestión Gimnasio",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
