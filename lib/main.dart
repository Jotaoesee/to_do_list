import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/mi_pagina_principal.dart';

// Función principal que arranca la aplicación Flutter.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación, que aparece en la barra de título del sistema.
      title: 'Mi Lista de Tareas',

      // Definición del tema de la aplicación, que define colores, fuentes, y otros estilos visuales.
      theme: ThemeData(
        // ColorScheme define los colores generales de la aplicación. Usa 'teal' como color base.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,

        // El color principal para la aplicación, se utiliza para los widgets que heredan este color.
        primarySwatch: Colors.teal,

        // Color de fondo para la aplicación, en este caso, un gris claro.
        scaffoldBackgroundColor: Colors.grey[100],

        // Personalización de la tipografía usando la fuente Lato de Google Fonts.
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          // Estilo para los textos normales.
          bodyMedium: const TextStyle(
              fontSize: 16, color: Color.fromARGB(221, 0, 153, 255)),
          // Estilo para los textos principales o títulos.
          displayMedium: const TextStyle(
              fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
        ),

        // Personalización de los checkboxes, como el color de relleno y de marca.
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(Colors.teal),
          checkColor: WidgetStateProperty.all(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Estilo para los ListTile (elementos de lista), aquí ajustamos el relleno.
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Personalización del botón flotante, cambiando su color de fondo y forma.
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),

        // Estilo para los SnackBar (mensajes emergentes), con un fondo de color teal.
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.teal.shade700,
          contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),

      // Widget principal de la aplicación, que es la página de tareas.
      home: const MiPaginaPrincipal(),

      // Definimos un contenedor para agregar un fondo con gradiente.
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // Definimos el gradiente de colores, que va de teal a tealAccent.
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topLeft, // Dirección del gradiente.
              end: Alignment.bottomRight, // Dirección del gradiente.
            ),
          ),
          child: child,
        );
      },
    );
  }
}
