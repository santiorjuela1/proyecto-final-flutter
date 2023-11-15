import 'package:fluter_final_to_do/screens/add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => navegarAddPage(context),
          child: const Icon(Icons.add)),
    );
  }
}

void navegarAddPage(BuildContext context) {
  final ruta = MaterialPageRoute(builder: (context) => AddTarea());
  Navigator.push(context, ruta);
}
