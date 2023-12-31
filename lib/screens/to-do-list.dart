import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_to_do/controllers/taskController.dart';
import 'package:flutter_final_to_do/screens/add_page.dart';
import 'package:flutter_final_to_do/screens/update_task.dart';
import 'package:flutter_final_to_do/services/TaskProvider.dart';
import 'package:provider/provider.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = TaskController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.tasks.isEmpty) {
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
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final tarea = taskProvider.tasks[index] as Map;
                    final id = tarea.containsKey('_id')
                        ? tarea['_id'] as String?
                        : null;
                    print('Task ID at index $index: $id');
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(tarea['title']),
                      subtitle: Text(tarea['description']),
                      trailing: PopupMenuButton(
                        onSelected: (value) => {
                          if (value == 'edit')
                            {
                              if (id != null)
                                {
                                  print(
                                      'entre al conditional para hacer update'),
                                  _navigateToUpdatePage(context, id),
                                }
                              else
                                {
                                  print(
                                      'entre al condicional para hacer update, pero soy null'),
                                }
                            }
                          else if (value == 'delete')
                            {
                              if (id != null)
                                {
                                  print('entre al conditional'),
                                  taskController.deleteById(id),
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

  void _navigateToUpdatePage(BuildContext context, String taskId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTaskScreen(taskId: taskId),
      ),
    );
  }

  // void _toggleTheme(BuildContext context) {
  //   final Brightness newBrightness =
  //       Theme.of(context).brightness == Brightness.light
  //           ? Brightness.dark
  //           : Brightness.light;

  //   //  EasyDynamicTheme.of(context).setBrightness(newBrightness);
  // }
}
