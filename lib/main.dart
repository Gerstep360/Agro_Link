// lib/main.dart

import 'package:flutter/material.dart';
import 'package:agro_link/screen/home_screen.dart';

void main() {
  runApp(AgroLinkApp());
}

class AgroLinkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroLink',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
