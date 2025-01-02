import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiPaginaPrincipal extends StatefulWidget {
  const MiPaginaPrincipal({super.key});

  @override
  State<MiPaginaPrincipal> createState() => _MiPaginaPrincipalState();
}

class _MiPaginaPrincipalState extends State<MiPaginaPrincipal> {
  // Lista de tareas y su estado (completada o no)
  List<String> tareas = [];
  List<bool> tareasCompletadas = [];

  @override
  void initState() {
    super.initState();
    _cargarTareas(); // Carga las tareas al iniciar la página
  }

  // Carga las tareas y su estado desde SharedPreferences
  Future<void> _cargarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tareas =
          prefs.getStringList('tareas') ?? []; // Obtiene la lista de tareas
      tareasCompletadas = List.generate(
        tareas.length,
        (index) =>
            prefs.getBool('tareaCompletada_$index') ??
            false, // Obtiene el estado de cada tarea
      );
    });
  }

  // Guarda las tareas y su estado en SharedPreferences
  Future<void> _guardarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tareas', tareas); // Guarda la lista de tareas
    for (int i = 0; i < tareasCompletadas.length; i++) {
      await prefs.setBool('tareaCompletada_$i',
          tareasCompletadas[i]); // Guarda el estado de cada tarea
    }
  }

  // Muestra un diálogo para agregar una nueva tarea
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
              onPressed: () => Navigator.pop(context), // Cierra el diálogo
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
                    tareas.add(
                        nuevaTarea.trim()); // Añade la nueva tarea a la lista
                    tareasCompletadas.add(
                        false); // Inicializa el estado de la tarea como incompleta
                    _guardarTareas(); // Guarda la tarea
                  });
                  Navigator.pop(context); // Cierra el diálogo
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

  // Muestra un diálogo para editar una tarea existente
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
            controller: TextEditingController(
                text: tareas[index]), // Muestra el texto actual de la tarea
            decoration: const InputDecoration(
              hintText: 'Edita tu tarea aquí...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context), // Cierra el diálogo sin guardar
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
                    tareas[index] =
                        tareaEditada.trim(); // Guarda la tarea editada
                    _guardarTareas(); // Actualiza las tareas guardadas
                  });
                  Navigator.pop(context); // Cierra el diálogo
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

  // Calcula el progreso de las tareas completadas
  double _calcularProgreso() {
    int tareasCompletadasCount = tareasCompletadas
        .where((tarea) => tarea)
        .length; // Cuenta las tareas completadas
    return tareas.isEmpty
        ? 0.0
        : tareasCompletadasCount / tareas.length; // Devuelve el progreso
  }

  @override
  Widget build(BuildContext context) {
    int tareasCompletadasCount = tareasCompletadas
        .where((tarea) => tarea)
        .length; // Cuenta las tareas completadas

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        centerTitle: true, // Centra el título en el AppBar
        iconTheme: const IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Mi Lista de Tareas',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Tamaño de la fuente del título
                  color: Colors.white, // Color del texto del título
                ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(158, 21, 170, 1),
                Color.fromRGBO(242, 116, 253, 1)
              ], // Gradiente de colores
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(80), // Altura personalizada para el AppBar
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tareas completadas: $tareasCompletadasCount/${tareas.length}', // Muestra el progreso de las tareas
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white, // Color del texto
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _calcularProgreso(), // Muestra el progreso
                  backgroundColor: Colors.grey[300],
                  color: _calcularProgreso() == 1.0
                      ? const Color.fromARGB(255, 0, 255,
                          0) // Verde si todas las tareas están completas
                      : const Color.fromARGB(
                          255, 0, 181, 253), // Azul de progreso
                  minHeight: 10,
                  semanticsLabel: 'Tareas completadas',
                )
              ],
            ),
          ),
        ),
      ),
      body: tareas.isEmpty
          ? Center(
              child: Text(
                "No hay tareas. ¡Añade una!", // Mensaje cuando no hay tareas
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              itemCount: tareas.length, // Número de tareas en la lista
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
                      tareas.removeAt(index); // Elimina la tarea
                      tareasCompletadas
                          .removeAt(index); // Elimina el estado de la tarea
                      _guardarTareas(); // Actualiza las tareas guardadas
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Tarea eliminada')), // Muestra mensaje de tarea eliminada
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8, // Sombra
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
                            value: tareasCompletadas[
                                index], // Checkbox para marcar tarea como completada
                            onChanged: (value) {
                              setState(() {
                                tareasCompletadas[index] =
                                    value!; // Cambia el estado de la tarea
                                _guardarTareas(); // Guarda el nuevo estado
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
                                        : null, // Muestra la tarea tachada si está completada
                                  ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _mostrarDialogoEditarTarea(
                                index), // Abre el diálogo para editar la tarea
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _mostrarDialogoAgregarTarea, // Abre el diálogo para agregar una nueva tarea
        child: const Icon(Icons.add),
      ),
    );
  }
}
