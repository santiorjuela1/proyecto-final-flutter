import 'dart:convert';

import 'package:fluter_final_to_do/model/TaskProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddTarea extends StatefulWidget {
  const AddTarea({super.key});

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
      /* Definimos los atributos de nuestra peticion */
      final titulo = titleController.text;
      final descripcion = descriptionController.text;

      /* Definimos el endpoint*/
      const url = 'https://api.nstack.in/v1/todos';
      final uri = Uri.parse(url);

      /* Definimos el body de la peticion */
      final body = {
        'title': titulo,
        'description': descripcion,
        'is_completed': false
      };

      /* Hacemos la peticion y recibimos la respuesta*/
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      /* Procesamos la respuesta */
      if (response.statusCode == 201) {
        titleController.text = '';
        descriptionController.text = '';

        Provider.of<TaskProvider>(context, listen: false).addTask({
          'id': jsonDecode(response.body)['id'],
          'title': titulo,
          'description': descripcion,
          'is_completed': false,
        });
        const String mensage = 'Su tarea fue creada!';
        mostrarMensajeExito(mensage);
      } else {
        const String mensage = 'Hubo un error. Intentelo de nuevo';
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
