import 'package:flutter/material.dart';

class Createnote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir"),
      ),
      body: Center(
        child: Text("Esta es la página de añadir", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}