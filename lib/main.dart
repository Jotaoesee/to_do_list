import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/mi_pagina_principal.dart';

/// Función principal que arranca la aplicación Flutter.
///
/// Este es el punto de entrada de la aplicación. [runApp] toma un Widget,
/// en este caso, nuestra aplicación principal [MyApp], y lo "infla" en el
/// árbol de widgets para mostrar la interfaz de usuario.
void main() {
  runApp(const MyApp());
}

/// [MyApp] es el widget raíz de la aplicación.
///
/// Es un [StatelessWidget] porque su configuración y apariencia
/// no cambian a lo largo del tiempo; solo define la estructura
/// básica de la aplicación (como el tema y la página de inicio).
class MyApp extends StatelessWidget {
  /// Constructor de [MyApp].
  ///
  /// Recibe una clave opcional [key] para identificar este widget.
  const MyApp({super.key});

  /// Construye la interfaz de usuario de la aplicación.
  ///
  /// Este método es llamado por el framework Flutter para describir
  /// la parte de la interfaz de usuario representada por este widget.
  ///
  /// Retorna un [MaterialApp], que es un widget de conveniencia
  /// que envuelve una aplicación que usa Material Design.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación que se muestra en la barra de título del sistema operativo
      // (por ejemplo, en el administrador de tareas de Android o en la pestaña del navegador para la web).
      title: 'Mi Lista de Tareas',

      // Define el tema visual de la aplicación.
      // Aquí se personalizan colores, tipografía y estilos de componentes.
      theme: ThemeData(
        // [ColorScheme] define los colores primarios, secundarios, de fondo, etc.,
        // de la aplicación basados en un color "semilla".
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // Usa 'teal' como color base para generar la paleta de colores.
          brightness: Brightness.light, // Define un tema claro.
        ),
        // Habilita las últimas características de Material Design 3.
        useMaterial3: true,

        // Color de fondo predeterminado para los Scaffold (páginas principales de la aplicación).
        scaffoldBackgroundColor: Colors.grey[100],

        // Personalización de la tipografía de la aplicación utilizando la fuente Lato de Google Fonts.
        // [GoogleFonts.latoTextTheme()] proporciona el tema de texto por defecto con Lato.
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          // Define el estilo predeterminado para la mayoría del texto en el cuerpo de la aplicación.
          bodyMedium: const TextStyle(
              fontSize: 16, color: Color.fromARGB(221, 0, 153, 255)), // Azul claro.
          // Define el estilo para textos de importancia como títulos o encabezados secundarios.
          displayMedium: const TextStyle(
              fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
        ),

        // Personalización del aspecto de los checkboxes.
        checkboxTheme: CheckboxThemeData(
          // Color de relleno del checkbox cuando está marcado.
          fillColor: WidgetStateProperty.all(Colors.teal),
          // Color de la marca (el "tick") dentro del checkbox.
          checkColor: WidgetStateProperty.all(Colors.white),
          // Define la forma de la casilla de verificación con bordes redondeados.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Estilo predeterminado para los [ListTile], que son widgets comunes para elementos de lista.
        listTileTheme: const ListTileThemeData(
          // Ajusta el relleno horizontal y vertical del contenido del ListTile.
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Personalización del estilo del botón flotante de acción ([FloatingActionButton]).
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          // Color de fondo del botón.
          backgroundColor: Colors.teal,
          // Color del contenido (icono o texto) del botón.
          foregroundColor: Colors.white,
          // Define la forma del botón como un círculo.
          shape: CircleBorder(),
        ),

        // Estilo para los [SnackBar] (mensajes emergentes temporales).
        snackBarTheme: SnackBarThemeData(
          // Color de fondo del SnackBar.
          backgroundColor: Colors.teal.shade700,
          // Estilo del texto que aparece dentro del SnackBar.
          contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),

      // El widget `home` define la pantalla inicial de la aplicación.
      // En este caso, es nuestra [MiPaginaPrincipal] personalizada.
      home: const MiPaginaPrincipal(),
    );
  }
}