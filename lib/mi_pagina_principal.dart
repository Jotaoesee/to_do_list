import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiPaginaPrincipal extends StatefulWidget {
  const MiPaginaPrincipal({super.key});

  @override
  State<MiPaginaPrincipal> createState() => _MiPaginaPrincipalState();
}

class _MiPaginaPrincipalState extends State<MiPaginaPrincipal> {
  List<String> tareas = [];
  List<bool> tareasCompletadas = [];

  @override
  void initState() {
    super.initState();
    _cargarTareas();
  }

  Future<void> _cargarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tareas = prefs.getStringList('tareas') ?? [];
      tareasCompletadas = List.generate(tareas.length,
          (index) => prefs.getBool('tareaCompletada_$index') ?? false);
    });
  }

  Future<void> _guardarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tareas', tareas);
    for (int i = 0; i < tareasCompletadas.length; i++) {
      await prefs.setBool('tareaCompletada_$i', tareasCompletadas[i]);
    }
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
          if (tareas.isEmpty) {
            // Comprobación clave
            return const Center(child: Text("No hay tareas. ¡Añade una!"));
          }

          final int tareaIndex = index;
          return ListTile(
            leading: Checkbox(
              value: tareasCompletadas.length > tareaIndex
                  ? tareasCompletadas[tareaIndex]
                  : false, //Comprobación de longitud de la lista
              onChanged: (value) {
                setState(() {
                  tareasCompletadas[tareaIndex] = value!;
                  _guardarTareas();
                });
              },
            ),
            title: Text(
              tareas[tareaIndex],
              style: TextStyle(
                decoration: tareasCompletadas.length > tareaIndex &&
                        tareasCompletadas[tareaIndex]
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final int tareaIndex = index;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Eliminar tarea'), // ¡Añadido!
                    content: const Text(
                        '¿Estás seguro de que quieres eliminar esta tarea?'), // ¡Añadido!
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            tareas.removeAt(tareaIndex);
                            tareasCompletadas.removeAt(tareaIndex);
                            _guardarTareas();
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                );
              },
            ),
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
