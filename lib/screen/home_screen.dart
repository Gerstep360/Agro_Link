// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:agro_link/cultivos/land.dart';
import 'package:agro_link/screen/add_land_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Land> lands = [];

  void addLand(Land land) {
    setState(() {
      lands.insert(0, land);
    });
  }

  void removeLand(int index) {
    setState(() {
      lands.removeAt(index);
    });
  }

  void editLand(int index, Land updatedLand) {
    setState(() {
      lands[index] = updatedLand;
    });
  }

  int get crossAxisCount => MediaQuery.of(context).size.width > 600 ? 3 : 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgroLink', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green.shade400,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: GridView.builder(
            itemCount: lands.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final land = lands[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: crossAxisCount,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildLandItem(land, index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddLandScreen(
                onSave: addLand,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLandItem(Land land, int index) {
    return GestureDetector(
      onTap: () async {
        final updatedLand = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddLandScreen(
              land: land,
              onSave: (editedLand) => editLand(index, editedLand),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 2)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(land.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Ubicación: ${land.location}', style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(height: 8),
              Text('Tamaño: ${NumberFormat('###,###.##').format(land.size)} ha', style: TextStyle(fontSize: 12)),
              SizedBox(height: 8),
              Text('Cultivo: ${land.crop}', style: TextStyle(fontSize: 12)),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeLand(index),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
