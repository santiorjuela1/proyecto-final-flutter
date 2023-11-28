import 'package:fluter_final_to_do/controllers/taskController.dart';
import 'package:fluter_final_to_do/services/TaskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTarea extends StatefulWidget {
  const AddTarea({super.key});

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final TaskController _taskController =
      TaskController(); // Create an instance of your controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tarea'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Titulo'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Descripcion'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: saveTask,
            child: const Text('Guardar'),
          )
        ],
      ),
    );
  }

  Future<void> saveTask() async {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      try {
        final titulo = titleController.text;
        final descripcion = descriptionController.text;

        final int statusCode = await _taskController.saveTask(
            titulo, descripcion); // Call the controller method

        print('Status code: $statusCode');

        if (statusCode == 201) {
          Provider.of<TaskProvider>(context, listen: false).getTasks();
          titleController.text = '';
          descriptionController.text = '';
          const String mensage = 'Su tarea fue creada!';
          mostrarMensajeExito(mensage);
        } else {
          const String mensage = 'Hubo un error. Intentelo de nuevo';
          mostrarMensajeFracaso(mensage);
        }
      } catch (e) {
        const String mensage = 'Hubo una excepcion. Intentelo de nuevo';
        mostrarMensajeFracaso(mensage);
      }
    }
  }

  void mostrarMensajeExito(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void mostrarMensajeFracaso(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
