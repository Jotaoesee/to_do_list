import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<String> tareas = ['Comprar pan', 'Estudiar Flutter', 'Hacer ejercicio'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Lista de Tareas',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Lista de Tareas'),
        ),
        body: ListView.builder(
          itemCount: tareas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tareas[index]),
            );
          },
        ),
      ),
    );
  }
}
