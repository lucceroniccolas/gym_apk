import 'package:flutter/material.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/providers/clases_provider.dart';
import 'package:provider/provider.dart';

void mostrarFormularioModificarClase(BuildContext context, Clase clase) {
  //accedemos al provider de clases
  final provider = Provider.of<ClasesProvider>(context);
  //cargamos la fecha actual de la clase en el provider
  provider.horarioClase = clase.horario;
  //controladores de texto para los campos del formulario
  //inicializamos los controladores con los valores actuales de la clase
  final nombreController = TextEditingController(text: clase.nombreClase);
  final descripcionController = TextEditingController(text: clase.descripcion);
  final cuposController = TextEditingController(text: clase.cupos.toString());

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        //solo se REconstruye si hacés setState()
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Modificar Clase'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration:
                      const InputDecoration(labelText: 'Nombre de la clase'),
                ),
                TextField(
                  controller: cuposController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Cupos"),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: "Descripción"),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final fecha = await showDatePicker(
                      //muestra el date picker (selector de fecha)
                      context: context,
                      initialDate: provider.horarioClase ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (fecha != null) {
                      setState(() {
                        //Llama a setState local para que el
                        //texto del botón se actualice
                        provider.horarioClase =
                            fecha; //guardamos la fecha seleccionada en el provider
                      });
                    }
                  },
                  //mostramos la fecha seleccionada o un texto por defecto
                  child: Text(
                    provider.horarioClase == null
                        ? "Seleccionar fecha"
                        : "Fecha: ${provider.horarioClase!.toLocal()}"
                            .split(' ')[0],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  provider.horarioClase = null; //limpiamos el horario
                  Navigator.pop(context); //cerramos el dialogo
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  //obtenemos los valores de los campos del formulario
                  //usamos trim para eliminar espacios al inicio y al final
                  final nombre = nombreController.text.trim();
                  final descripcion = descripcionController.text.trim();
                  final cupos = int.tryParse(cuposController.text.trim());

                  if (nombre.isNotEmpty &&
                      descripcion.isNotEmpty &&
                      provider.horarioClase != null &&
                      cupos != null) {
                    //usamos copyWith para crear una nueva instancia de Clase con los cambios
                    final claseModificada = clase.copyWith(
                        nombreClase: nombre,
                        descripcion: descripcion,
                        horario: provider.horarioClase,
                        cupos: cupos);

                    await provider.modificarClase(
                        clase.idClase, claseModificada);
                    provider.horarioClase = null; //limpiamos el horario
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          );
        },
      );
    },
  );
}
