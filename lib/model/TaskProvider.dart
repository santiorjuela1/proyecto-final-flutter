import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  // Atributos
  List<dynamic> _tasks = [];


  // Metodos
  List<dynamic> get tasks => _tasks;

    void addTask(Map<String, dynamic> task) {
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> getTasks() async {
    // Your existing code for fetching tasks
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      print(json);
      final resultado = json['items'] as List;

      _tasks = resultado;
      notifyListeners();
    } else {
      print('Error');
    }
  }

  void deleteById(String? id) async {
    if (id == null) {
      print('id is null');
      return;
    }

    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // Assuming you have a method to find and remove the task from the list
      print('${id} has been deleted');
      _removeTaskById(id);
      notifyListeners(); // Notify listeners that the state has changed
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
