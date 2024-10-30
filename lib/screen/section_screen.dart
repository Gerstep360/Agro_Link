// lib/screens/section_screen.dart

import 'package:flutter/material.dart';

class SectionScreen extends StatelessWidget {
  final String sectionName;

  SectionScreen({required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sectionName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Número de productos/ofertas en la sección
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.eco, color: Colors.green),
              title: Text('$sectionName $index'),
              subtitle: Text('Detalles del producto/oferta'),
              trailing: Text('\$${(index + 1) * 10}.00'),
            );
          },
        ),
      ),
    );
  }
}
