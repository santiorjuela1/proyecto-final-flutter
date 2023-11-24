import 'dart:convert';

import 'package:fluter_final_to_do/model/TaskProvider.dart';
import 'package:fluter_final_to_do/screens/add_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.tasks.isEmpty) {
            // Display a message when there are no tasks
            return const Center(
              child: Text(
                'No hay ninguna tarea',
                style: TextStyle(fontSize: 18.0),
              ),
            );
          } else {
            // Display the list of tasks
            return RefreshIndicator(
              onRefresh: () => taskProvider.getTasks(),
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final tarea = taskProvider.tasks[index] as Map;
                  final id =
                      tarea.containsKey('_id') ? tarea['_id'] as String? : null;
                  print('Task ID at index $index: $id');
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(tarea['title']),
                    subtitle: Text(tarea['description']),
                    trailing: PopupMenuButton(
                      onSelected: (value) => {
                        if (value == 'edit')
                          {
                            taskProvider.printingTasks(),
                          }
                        else if (value == 'delete')
                          {
                            if (id != null)
                              {
                                print('entre al conditional'),
                                taskProvider.deleteById(id),
                              }
                            else
                              {
                                print('entre al condicional, pero soy null'),
                              }
                          }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                              value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(
                              value: 'delete', child: Text('Delete')),
                        ];
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddPage(BuildContext context) {
    final ruta = MaterialPageRoute(builder: (context) => const AddTarea());
    Navigator.push(context, ruta);
  }
}
