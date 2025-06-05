import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection/injection_container.dart';
import 'ui/homePage.dart';
import 'providers/clases_provider.dart';
import 'providers/usuario_provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //me ayuda a asegurar que flutter esté listo
  await init(); //preparamos e inyectamos todas las dependecias necesarias antes que arranque la apk
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final providerClases = getIt<ClasesProvider>();
          providerClases.obtenerClases();
          return providerClases;
        }),
      ],
      child: MaterialApp(
          title: "GYM APK",
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: const Homepage()),
    );
  }
}
