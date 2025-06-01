import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [MiPaginaPrincipal] es el widget principal que representa la pantalla
/// de la lista de tareas pendientes.
///
/// Es un [StatefulWidget] porque su estado (la lista de tareas y su progreso)
/// puede cambiar durante la vida de la aplicación.
class MiPaginaPrincipal extends StatefulWidget {
  /// Constructor de [MiPaginaPrincipal].
  ///
  /// Recibe una clave opcional [key] para identificar este widget.
  const MiPaginaPrincipal({super.key});

  /// Crea el estado mutable para este widget.
  ///
  /// Retorna una instancia de [_MiPaginaPrincipalState], que es la clase
  /// que mantiene el estado de [MiPaginaPrincipal].
  @override
  State<MiPaginaPrincipal> createState() => _MiPaginaPrincipalState();
}

/// [_MiPaginaPrincipalState] maneja el estado y la lógica de la [MiPaginaPrincipal].
///
/// Contiene las listas de tareas y su estado de completitud, así como los métodos
/// para cargar, guardar, agregar, editar y eliminar tareas, y calcular el progreso.
class _MiPaginaPrincipalState extends State<MiPaginaPrincipal> {
  /// Lista de las cadenas de texto que representan cada tarea.
  List<String> tareas = [];

  /// Lista de booleanos que representan el estado de completitud de cada tarea,
  /// en correspondencia con la lista [tareas]. `true` significa completada.
  List<bool> tareasCompletadas = [];

  /// Se llama una vez cuando el widget se inserta en el árbol de widgets.
  ///
  /// Se utiliza para inicializar datos, en este caso, cargando las tareas
  /// guardadas.
  @override
  void initState() {
    super.initState();
    _cargarTareas(); // Carga las tareas y su estado desde el almacenamiento local.
  }

  /// Carga las tareas y su estado de completitud desde [SharedPreferences].
  ///
  /// Utiliza `getStringList` para obtener la lista de tareas y `getBool`
  /// para el estado individual de cada tarea, basado en su índice.
  /// Si no hay datos guardados, inicializa las listas vacías o con `false`.
  Future<void> _cargarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tareas = prefs.getStringList('tareas') ?? []; // Obtiene la lista de tareas guardadas.
      // Genera una lista de estados de completitud, recuperando cada booleano guardado
      // o `false` si no existe para una tarea específica.
      tareasCompletadas = List.generate(
        tareas.length,
        (index) =>
            prefs.getBool('tareaCompletada_$index') ??
            false, // Obtiene el estado de completitud de cada tarea.
      );
    });
  }

  /// Guarda las tareas y su estado de completitud en [SharedPreferences].
  ///
  /// Guarda la lista completa de tareas con `setStringList` y luego itera
  /// sobre [tareasCompletadas] para guardar el estado booleano de cada tarea
  /// individualmente, usando una clave única para cada una.
  Future<void> _guardarTareas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tareas', tareas); // Guarda la lista de todas las tareas.
    for (int i = 0; i < tareasCompletadas.length; i++) {
      await prefs.setBool('tareaCompletada_$i',
          tareasCompletadas[i]); // Guarda el estado de completitud individual.
    }
  }

  /// Muestra un diálogo emergente ([AlertDialog]) para permitir al usuario
  /// agregar una nueva tarea a la lista.
  ///
  /// Contiene un [TextField] para la entrada de texto y botones para
  /// cancelar o agregar la tarea. Valida que la tarea no esté vacía.
  void _mostrarDialogoAgregarTarea() {
    showDialog(
      context: context,
      builder: (context) {
        String nuevaTarea = ''; // Variable temporal para la nueva tarea.
        return AlertDialog(
          title: Text(
            'Agregar nueva tarea',
            style: Theme.of(context).textTheme.titleMedium, // Estilo de título del tema.
          ),
          content: TextField(
            onChanged: (value) {
              nuevaTarea = value; // Actualiza la variable temporal al cambiar el texto.
            },
            decoration: const InputDecoration(
              hintText: 'Escribe tu tarea aquí...', // Texto de sugerencia.
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cierra el diálogo sin agregar.
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge, // Estilo de botón del tema.
              ),
            ),
            TextButton(
              onPressed: () {
                if (nuevaTarea.trim().isEmpty) {
                  // Muestra un [SnackBar] si la tarea está vacía.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La tarea no puede estar vacía'),
                    ),
                  );
                } else {
                  setState(() {
                    tareas.add(nuevaTarea.trim()); // Añade la nueva tarea a la lista.
                    tareasCompletadas.add(
                        false); // Inicializa el estado de la tarea como incompleta.
                    _guardarTareas(); // Guarda las listas actualizadas en almacenamiento.
                  });
                  Navigator.pop(context); // Cierra el diálogo después de agregar.
                }
              },
              child: Text(
                'Agregar',
                style: Theme.of(context).textTheme.labelLarge, // Estilo de botón del tema.
              ),
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo emergente ([AlertDialog]) para permitir al usuario
  /// editar una tarea existente en la lista.
  ///
  /// Recibe el [index] de la tarea a editar. Muestra el texto actual de la tarea
  /// en un [TextField] y permite al usuario modificarlo.
  void _mostrarDialogoEditarTarea(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String tareaEditada = tareas[index]; // Variable temporal con el texto actual de la tarea.
        return AlertDialog(
          title: Text(
            'Editar tarea',
            style: Theme.of(context).textTheme.titleMedium, // Estilo de título del tema.
          ),
          content: TextField(
            onChanged: (value) {
              tareaEditada = value; // Actualiza la variable temporal con el nuevo texto.
            },
            controller: TextEditingController(
                text: tareas[index]), // Controlador para mostrar el texto actual de la tarea.
            decoration: const InputDecoration(
              hintText: 'Edita tu tarea aquí...', // Texto de sugerencia.
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context), // Cierra el diálogo sin guardar cambios.
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge, // Estilo de botón del tema.
              ),
            ),
            TextButton(
              onPressed: () {
                if (tareaEditada.trim().isEmpty) {
                  // Muestra un [SnackBar] si la tarea editada está vacía.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La tarea no puede estar vacía'),
                    ),
                  );
                } else {
                  setState(() {
                    tareas[index] =
                        tareaEditada.trim(); // Actualiza la tarea en la lista.
                    _guardarTareas(); // Guarda las listas actualizadas en almacenamiento.
                  });
                  Navigator.pop(context); // Cierra el diálogo después de guardar.
                }
              },
              child: Text(
                'Guardar',
                style: Theme.of(context).textTheme.labelLarge, // Estilo de botón del tema.
              ),
            ),
          ],
        );
      },
    );
  }

  /// Calcula el porcentaje de progreso de las tareas completadas.
  ///
  /// Itera sobre [tareasCompletadas] para contar cuántas son `true`.
  /// Retorna un valor [double] entre 0.0 y 1.0. Si no hay tareas, retorna 0.0
  /// para evitar divisiones por cero.
  double _calcularProgreso() {
    int tareasCompletadasCount = tareasCompletadas
        .where((tarea) => tarea)
        .length; // Cuenta las tareas marcadas como completadas.
    return tareas.isEmpty
        ? 0.0
        : tareasCompletadasCount /
            tareas.length; // Calcula el progreso como un porcentaje.
  }

  /// Construye la interfaz de usuario de la página principal de la aplicación.
  ///
  /// Este método describe cómo se ve la interfaz de usuario en cualquier
  /// momento dado, basándose en el estado actual de [tareas] y [tareasCompletadas].
  @override
  Widget build(BuildContext context) {
    // Calcula el número de tareas completadas para mostrar en el AppBar.
    int tareasCompletadasCount =
        tareasCompletadas.where((tarea) => tarea).length;

    return Scaffold(
      // [AppBar] de la aplicación con un título, gradiente de color y barra de progreso.
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5), // Fondo semi-transparente para el AppBar.
        elevation: 0, // Sin sombra.
        centerTitle: true, // Centra el título en el AppBar.
        iconTheme: const IconThemeData(color: Colors.white), // Color de los iconos en el AppBar.
        title: Padding(
          padding: const EdgeInsets.only(top: 10), // Relleno superior para el título.
          child: Text(
            'Mi Lista de Tareas',
            // Estilo del título, personalizando el color y tamaño de fuente.
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
          ),
        ),
        // [flexibleSpace] permite colocar un widget detrás del AppBar, ideal para gradientes.
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(158, 21, 170, 1), // Color morado oscuro.
                Color.fromRGBO(242, 116, 253, 1) // Color rosa claro.
              ],
              begin: Alignment.topLeft, // Inicio del gradiente.
              end: Alignment.bottomRight, // Fin del gradiente.
            ),
          ),
        ),
        // [bottom] permite agregar un widget en la parte inferior del AppBar,
        // aquí se usa para mostrar el progreso de las tareas.
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(80), // Altura personalizada para esta sección.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Relleno horizontal.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido a la izquierda.
              children: [
                // Texto que muestra el contador de tareas completadas.
                Text(
                  'Tareas completadas: $tareasCompletadasCount/${tareas.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8), // Espacio vertical.
                // Barra de progreso lineal que muestra el porcentaje de tareas completadas.
                LinearProgressIndicator(
                  value: _calcularProgreso(), // Valor de progreso (0.0 a 1.0).
                  backgroundColor: Colors.grey[300], // Color de fondo de la barra.
                  // Color del progreso: verde si todas completadas, azul si no.
                  color: _calcularProgreso() == 1.0
                      ? const Color.fromARGB(255, 0, 255, 0)
                      : const Color.fromARGB(255, 0, 181, 253),
                  minHeight: 10, // Altura mínima de la barra.
                  semanticsLabel: 'Tareas completadas', // Etiqueta para accesibilidad.
                )
              ],
            ),
          ),
        ),
      ),
      // Cuerpo de la aplicación, que muestra la lista de tareas o un mensaje si no hay ninguna.
      body: tareas.isEmpty
          ? Center(
              child: Text(
                "No hay tareas. ¡Añade una!", // Mensaje cuando no hay tareas.
                style: Theme.of(context).textTheme.bodyMedium, // Estilo de texto del tema.
              ),
            )
          : ListView.builder(
              itemCount: tareas.length, // Número total de elementos en la lista.
              itemBuilder: (context, index) {
                // [Dismissible] permite deslizar elementos de la lista para eliminarlos.
                return Dismissible(
                  key: ValueKey(tareas[index]), // Clave única para identificar el elemento.
                  // Fondo que aparece al deslizar hacia la izquierda.
                  background: Container(
                    color: Colors.redAccent, // Color de fondo rojo.
                    alignment: Alignment.centerLeft, // Alinea el icono a la izquierda.
                    padding: const EdgeInsets.symmetric(horizontal: 20), // Relleno.
                    child: const Icon(Icons.delete,
                        color: Colors.white), // Icono de borrar.
                  ),
                  // Fondo que aparece al deslizar hacia la derecha.
                  secondaryBackground: Container(
                    color: Colors.redAccent, // Color de fondo rojo.
                    alignment: Alignment.centerRight, // Alinea el icono a la derecha.
                    padding: const EdgeInsets.symmetric(horizontal: 20), // Relleno.
                    child: const Icon(Icons.delete,
                        color: Colors.white), // Icono de borrar.
                  ),
                  // Callback que se ejecuta cuando un elemento es deslizado completamente.
                  onDismissed: (direction) {
                    setState(() {
                      tareas.removeAt(index); // Elimina la tarea de la lista.
                      tareasCompletadas
                          .removeAt(index); // Elimina el estado de completitud asociado.
                      _guardarTareas(); // Guarda los cambios en el almacenamiento.
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Tarea eliminada')), // Muestra un SnackBar de confirmación.
                    );
                  },
                  // Contenido real de cada elemento de la lista (una tarjeta con la tarea).
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margen de la tarjeta.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bordes redondeados.
                    ),
                    elevation: 8, // Sombra de la tarjeta.
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16), // Relleno interno de la tarjeta.
                      child: Row(
                        children: [
                          const Icon(
                            Icons.swipe, // Icono indicando que se puede deslizar.
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 12), // Espacio horizontal.
                          // [Checkbox] para marcar/desmarcar la tarea como completada.
                          Checkbox(
                            value: tareasCompletadas[
                                index], // Valor actual del checkbox.
                            onChanged: (value) {
                              setState(() {
                                tareasCompletadas[index] =
                                    value!; // Actualiza el estado de completitud.
                                _guardarTareas(); // Guarda el nuevo estado.
                              });
                            },
                          ),
                          // [Expanded] asegura que el texto de la tarea ocupe el espacio disponible.
                          Expanded(
                            child: Text(
                              tareas[index],
                              // Estilo del texto de la tarea, con tachado si está completada.
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    decoration: tareasCompletadas[index]
                                        ? TextDecoration
                                            .lineThrough // Texto tachado si completada.
                                        : null, // Sin tachado si no completada.
                                  ),
                            ),
                          ),
                          // Botón para editar la tarea.
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue), // Icono de edición.
                            onPressed: () => _mostrarDialogoEditarTarea(
                                index), // Abre el diálogo de edición.
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      // Botón de acción flotante para agregar una nueva tarea.
      floatingActionButton: FloatingActionButton(
        onPressed:
            _mostrarDialogoAgregarTarea, // Llama a la función para mostrar el diálogo.
        child: const Icon(Icons.add), // Icono de añadir.
      ),
    );
  }
}