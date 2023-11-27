<<<<<<< HEAD
import 'package:fluter_final_to_do/screens/login.dart';
=======
import 'package:fluter_final_to_do/model/TaskProvider.dart';
>>>>>>> e2bf3bb984df1586715defddc886010512a10025
import 'package:fluter_final_to_do/screens/to-do-list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
=======
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const ToDoList()),
>>>>>>> e2bf3bb984df1586715defddc886010512a10025
    );
  }
}
