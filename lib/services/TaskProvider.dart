import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  // Atributos
  List<dynamic> _tasks = [];
  // Metodos
  List<dynamic> get tasks => _tasks;

  // CREATE TASK
  Future<int> createTask(Map<String, dynamic> task) async {
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);

    final body = {
      'title': task['title'],
      'description': task['description'],
      'is_completed': false,
    };

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      print('Task created successfully.');
      final createdTask = {
        'id': jsonDecode(response.body)['id'],
        'title': task['title'],
        'description': task['description'],
        'is_completed': false,
      };
      _tasks.add(createdTask);
      notifyListeners();
    } else {
      print('Error creating task: ${response.statusCode}');
      throw Exception('Failed to create task.');
    }
    return response.statusCode;
  }

  // AGREGAR TASK
  void addTask(Map<String, dynamic> task) {
    _tasks.add(task);
    notifyListeners();
  }

  // GET ALL TASKS
  Future<void> getTasks() async {
    // Your existing code for fetching tasks
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final resultado = json['items'] as List;

      _tasks = resultado;
      notifyListeners();
    } else {
      print('Error');
    }
  }

  // UPDATE TASK
  Future<void> updateTask(
      String taskId, String updatedTitle, String updatedDescription) async {
    final body = {
      'title': updatedTitle,
      'description': updatedDescription,
      'is_completed': false,
    };

    final url = 'https://api.nstack.in/v1/todos/$taskId';
    final uri = Uri.parse(url);

    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    print('response: ${response.body}');
    notifyListeners();

    if (response.statusCode != 200) {
      throw Exception('Failed to update task.');
    }
  }

  Future<void> deleteById(String? id) async {
    if (id == null) {
      print('id is null');
      return;
    }

    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      // Assuming you have a method to find and remove the task from the list
      print('${id} has been deleted');
      _removeTaskById(id);
    } else {
      print('Error deleting task: ${response.statusCode}');
    }
  }

  void _removeTaskById(String id) {
    _tasks.removeWhere((task) => task['_id'] == id);
    notifyListeners();
  }

  void printingTasks() {
    for (var i = 0; i < _tasks.length; i++) {
      print(_tasks[i]);
    }
  }
}
