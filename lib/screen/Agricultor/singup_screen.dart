import 'package:flutter/material.dart';
import 'package:agro_link/services/auth_service.dart';
import 'package:agro_link/models/Agricultor/agricultor.dart';
import 'package:agro_link/themes/themes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _informacionBancariaController = TextEditingController();
  final TextEditingController _nitController = TextEditingController();
  final TextEditingController _carnetController = TextEditingController();
  final TextEditingController _licenciaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  final AuthService _authService = AuthService();

  void _register() async {
    try {
      Agricultor newAgricultor = Agricultor(
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        email: _emailController.text,
        telefono: _telefonoController.text,
        informacionBancaria: _informacionBancariaController.text,
        nit: _nitController.text,
        carnet: _carnetController.text,
        licenciaFuncionamiento: _licenciaController.text,
        estado: _estadoController.text,
        direccion: _direccionController.text,
      );

      await _authService.registerAgricultor(newAgricultor);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos enviados correctamente')),
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        title: const Text('Registro de Agricultor'),
        backgroundColor: Themes.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(controller: _nombreController, hint: 'Nombre'),
              _buildTextField(controller: _apellidoController, hint: 'Apellido'),
              _buildTextField(controller: _emailController, hint: 'Correo electrónico'),
              _buildTextField(controller: _telefonoController, hint: 'Teléfono'),
              _buildTextField(controller: _informacionBancariaController, hint: 'Información bancaria'),
              _buildTextField(controller: _nitController, hint: 'NIT'),
              _buildTextField(controller: _carnetController, hint: 'Carnet'),
              _buildTextField(controller: _licenciaController, hint: 'Licencia de funcionamiento'),
              _buildTextField(controller: _estadoController, hint: 'Estado'),
              _buildTextField(controller: _direccionController, hint: 'Dirección'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                style: Themes.buttonStyle(),
                child: const Text('Registrar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hint, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: Themes.inputDecoration(hintText: hint),
        obscureText: obscureText,
        style: const TextStyle(color: Themes.textColor),
      ),
    );
  }
}
