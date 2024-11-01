import 'package:flutter/material.dart';
import 'package:agro_link/screen/agricultor/login_screen.dart';
import 'package:agro_link/screen/agricultor/singup_screen.dart'; // Asegúrate de que la ruta sea correcta

void main() {
  runApp(const AgroLinkApp());
}

class AgroLinkApp extends StatelessWidget {
  const AgroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agro Link',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.greenAccent, // Color principal
        hintColor: Colors.greenAccent,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => SignUpScreen(),
        // '/home': (context) => HomeScreen(), // Descomenta si es necesario
      },
    );
  }
}
