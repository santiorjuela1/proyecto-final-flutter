import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget { 
  const LoginPage({Key? key}) : super(key: key);
  
   @override
  State<LoginPage> createState() => _LoginPageState();
  }
  class _LoginPageState extends State<LoginPage> {
    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android,
                size: 100,
                ),
                SizedBox(height: 75),
              //bienvenida!
                  Text(
                    "Bienvenido de nuevo!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(height: 50),    
              //correo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Correo Electronico",
                          ),                       
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
              //contraseña
              Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Contraseña",
                          ),                       
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  
              //boton de inicio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Inicio sesion",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        ),
                    ),
                  ),                
                ),
              ),
              SizedBox(height: 25),

              //Nuevo usuario
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Eres nuevo?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " Registrate ahora",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
                  
            ),
          ),
        )
      );
    }
  }

