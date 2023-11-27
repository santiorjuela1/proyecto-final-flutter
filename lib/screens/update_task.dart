import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateTaskScreen extends StatefulWidget {
  final String taskId;

  const UpdateTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actualizar tarea: ${widget.taskId}'),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _updateTask(),
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTask() async {
    // Implement the logic to update the task using the provided controllers
    final updatedTitle = titleController.text;
    final updatedDescription = descriptionController.text;

    final body = {
      'title': updatedTitle,
      'description': updatedDescription,
      'is_completed': false,
    };

    final url =
        'https://api.nstack.in/v1/todos/${widget.taskId}'; // Use widget.taskId here
    final uri = Uri.parse(url);

    // Implement the API call or database update logic here
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    print(response.body);

    if (response.statusCode == 200) {
      titleController.text = '';
      descriptionController.text = '';

      final jsonResponse = jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update task.');
    }

    // After updating, you might want to navigate back to the main task list screen
    Navigator.pop(context);
  }
}
