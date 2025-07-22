import 'package:flutter/material.dart';

//Creé el siguiente boton para no tener que andar repitiendo elevated buttons por todos lados
//Es mucho más limpio

class BotonAccion extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  const BotonAccion({
    super.key,
    required this.texto,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16)),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
