
import 'package:flutter/material.dart';
import 'package:flutter_final_to_do/controllers/taskController.dart';

class UpdateTaskScreen extends StatefulWidget {
  final String taskId;

  const UpdateTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final TaskController _taskController = TaskController();

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
    try {
      await _taskController.updateTask(
        widget.taskId,
        titleController.text,
        descriptionController.text,
      );

      titleController.text = '';
      descriptionController.text = '';

      // After updating, you might want to navigate back to the main task list screen
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      // Handle error, show a snackbar, etc.
    }
  }
}
