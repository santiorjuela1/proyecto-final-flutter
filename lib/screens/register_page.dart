import 'dart:ffi';

import 'package:fluter_final_to_do/screens/login.dart';
import 'package:fluter_final_to_do/screens/to-do-list.dart';
import 'package:flutter/material.dart';
import 'package:fluter_final_to_do/model/user.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.android,
                  size: 100,
                ),
                const SizedBox(height: 75),
                // Bienvenida!
                const Text(
                  "Bienvenido a to-do list app!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Completa tu registro con tus datos!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 50),
                // Nombre
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
                        controller: _nameController,
                        maxLength: 30,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nombre",
                          hintStyle: TextStyle(color: Colors.purple),
                        ),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Correo
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
                        controller: _emailController,
                        maxLength: 50,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Correo electronico",
                          hintStyle: TextStyle(color: Colors.purple),
                        ),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //  Contraseña
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
                        controller: _passwordController,
                        maxLength: 20,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Contraseña",
                          hintStyle: TextStyle(color: Colors.purple),
                        ),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Confirmar contraseña
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
                        controller: _confirmPasswordController,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirmar contraseña",
                          hintStyle: TextStyle(color: Colors.purple),
                        ),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Teléfono
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
                        controller: _phoneController,
                        maxLength: 15,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Teléfono",
                          hintStyle: TextStyle(color: Colors.purple),
                        ),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Botón de Registro
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: () => signUp(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor:
                          Colors.deepPurple, // Set the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Registrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                // ¿Ya tienes cuenta?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Ya tienes cuenta?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change the color if needed
                      ),
                    ),
                    const SizedBox(height: 10), // Adjust the spacing
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the login page
                        navigateToLoginPage(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.transparent, // Make the button transparent
                        elevation: 0, // Remove the button elevation
                      ),
                      child: const Text(
                        "Inicia sesión ahora",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    // Obtener datos del formulario
    String correo = _emailController.text;
    String nombre = _nameController.text;
    String contrasena = _passwordController.text;
    String confirmarContrasena = _confirmPasswordController.text;
    String telefono = _phoneController.text;

    // Verificar si algún campo está vacío
    if (correo.isEmpty ||
        contrasena.isEmpty ||
        confirmarContrasena.isEmpty ||
        telefono.isEmpty ||
        nombre.isEmpty) {
      // Manejar el caso en que algún campo esté vacío
      mostrarMensajeFracaso("Todos los campos deben ser completados");
      return;
    }

    // Verificar si las contraseñas coinciden
    if (contrasena != confirmarContrasena) {
      // Manejar el caso en que las contraseñas no coincidan
      mostrarMensajeFracaso("Las contraseñas no coinciden");
      return;
    }

    // Obtener el usuario registrado
    Usuario unicoUsuario = Usuario.instance;

    // Verificar si el usuario ya existe

    if (unicoUsuario.contrasena.isNotEmpty &&
        unicoUsuario.correoElectronico.isNotEmpty &&
        unicoUsuario.nombre.isNotEmpty &&
        unicoUsuario.numero != 0) {
      mostrarMensajeFracaso("El usuario ya existe. No podemos crear otro.");
      return;
    }

    // Configurar las propiedades del usuario
    unicoUsuario.contrasena = contrasena;
    unicoUsuario.correoElectronico = correo;
    unicoUsuario.nombre = nombre;
    unicoUsuario.numero = int.parse(telefono);

    // Ejemplo de navegación a la página de inicio después de un registro exitoso
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(showRegisterPage: () {}),
      ),
    );
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

  void navigateToLoginPage(BuildContext context) {
    final ruta = MaterialPageRoute(
        builder: (context) => LoginPage(showRegisterPage: () {}));
    Navigator.pushReplacement(context, ruta);
  }
}
