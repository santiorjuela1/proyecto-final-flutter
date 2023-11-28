class Usuario {
  String correoElectronico;
  String contrasena;

  Usuario({required this.correoElectronico, required this.contrasena});

  // Método para verificar las credenciales
  bool verificarCredenciales(String correo, String contrasena) {
    return this.correoElectronico == correo && this.contrasena == contrasena;
  }
}
