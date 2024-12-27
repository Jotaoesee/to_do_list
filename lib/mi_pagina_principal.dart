import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiPaginaPrincipal extends StatefulWidget {
  const MiPaginaPrincipal({super.key});

  @override
  State<MiPaginaPrincipal> createState() => _MiPaginaPrincipalState();
}

class _MiPaginaPrincipalState extends State<MiPaginaPrincipal> {
  List<String> tareas = [];

  @override
  void initState() {
    super.initState();
    _cargarTareas();
  }

  Future<void> _guardarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tareas', tareas);
  }

  Future<void> _cargarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tareas = prefs.getStringList('tareas') ??
          []; // Carga las tareas o una lista vacía si no hay nada guardado
    });
  }

  void _mostrarDialogoAgregarTarea() {
    showDialog(
      context: context,
      builder: (context) {
        String nuevaTarea = '';

        return AlertDialog(
          title: const Text('Agregar nueva tarea'),
          content: TextField(
            onChanged: (value) {
              nuevaTarea = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tareas.add(nuevaTarea);
                  _guardarTareas();
                });
                Navigator.pop(context);
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregarTarea,
        child: const Icon(Icons.add),
      ),
    );
  }
}
