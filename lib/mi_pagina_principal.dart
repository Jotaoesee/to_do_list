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
      tareasCompletadas = List.generate(
        tareas.length,
        (index) => prefs.getBool('tareaCompletada_$index') ?? false,
      );
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
          title: Text(
            'Agregar nueva tarea',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: TextField(
            onChanged: (value) {
              nuevaTarea = value;
            },
            decoration: const InputDecoration(
              hintText: 'Escribe tu tarea aquí...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            TextButton(
              onPressed: () {
                if (nuevaTarea.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La tarea no puede estar vacía'),
                    ),
                  );
                } else {
                  setState(() {
                    tareas.add(nuevaTarea.trim());
                    tareasCompletadas.add(false);
                    _guardarTareas();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Agregar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoEditarTarea(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String tareaEditada = tareas[index];
        return AlertDialog(
          title: Text(
            'Editar tarea',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: TextField(
            onChanged: (value) {
              tareaEditada = value;
            },
            controller: TextEditingController(text: tareas[index]),
            decoration: const InputDecoration(
              hintText: 'Edita tu tarea aquí...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            TextButton(
              onPressed: () {
                if (tareaEditada.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La tarea no puede estar vacía'),
                    ),
                  );
                } else {
                  setState(() {
                    tareas[index] = tareaEditada.trim();
                    _guardarTareas();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Guardar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
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
        title: Text(
          'Mi Lista de Tareas',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: tareas.isEmpty
          ? Center(
              child: Text(
                "No hay tareas. ¡Añade una!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(tareas[index]),
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      tareas.removeAt(index);
                      tareasCompletadas.removeAt(index);
                      _guardarTareas();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tarea eliminada')),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.swipe,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Checkbox(
                            value: tareasCompletadas[index],
                            onChanged: (value) {
                              setState(() {
                                tareasCompletadas[index] = value!;
                                _guardarTareas();
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              tareas[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    decoration: tareasCompletadas[index]
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _mostrarDialogoEditarTarea(index),
                          ),
                        ],
                      ),
                    ),
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
