✅ Mi Lista de Tareas: Tu Organizador Personal Inteligente 🚀
Descripción del Proyecto
Esta intuitiva aplicación móvil, desarrollada con Flutter, te permite gestionar tus tareas diarias de un vistazo. Desde apuntar una nueva idea hasta marcar una tarea como completada, esta aplicación te ayuda a mantener el control de tus pendientes y a visualizar tu progreso.

Diseñada para ser rápida y fácil de usar, Mi Lista de Tareas se enfoca en la funcionalidad esencial que necesitas para ser más productivo. Tus tareas se guardan de forma segura en tu dispositivo, asegurando que siempre estén disponibles, incluso sin conexión.

El Problema que Resuelve
En el ajetreo diario, es fácil perder el rastro de las tareas y sentirse abrumado. Mi Lista de Tareas aborda este problema ofreciendo una solución clara para:

Centralizar tus pendientes: Ten todas tus tareas en un solo lugar, eliminando la dispersión de notas y recordatorios.

Simplificar la gestión de tareas: Añade, edita, marca como completada o elimina tareas con gestos intuitivos.

Motivar el progreso: Visualiza cuánto has avanzado con una barra de progreso que te anima a completar tus objetivos.

Mantener la persistencia: Tus tareas se guardan automáticamente, para que nunca pierdas un pendiente importante.

¿Para Quién es Útil?
Mi Lista de Tareas es una herramienta ideal para:

Uso personal: Para organizar tus quehaceres diarios, compras, estudio o proyectos personales.

Estudiantes: Para llevar un registro de tareas escolares, fechas de entrega y apuntes rápidos.

Cualquier persona que necesite un método simple y eficaz para recordar y gestionar sus actividades.

Desarrolladores de Flutter: Como un excelente ejemplo de aplicación CRUD (Crear, Leer, Actualizar, Borrar) con persistencia de datos local (SharedPreferences) y una interfaz de usuario atractiva.

✨ Características Destacadas
➕ Gestión Completa de Tareas (CRUD):

Añadir: Crea nuevas tareas de forma rápida a través de un diálogo emergente.

Ver: Visualiza todas tus tareas en una lista limpia y desplazable.

Editar: Modifica el texto de cualquier tarea existente con un toque.

Marcar como Completada: Utiliza un práctico Checkbox para alternar el estado de cada tarea.

Eliminar: Desliza una tarea hacia la izquierda o derecha para borrarla de tu lista.

💾 Persistencia Local de Datos: Todas tus tareas y su estado se guardan automáticamente en el almacenamiento de tu dispositivo, asegurando que tus pendientes estén seguros y accesibles incluso si cierras la aplicación o reinicias tu teléfono.

📊 Seguimiento de Progreso Visual: Una barra de progreso intuitiva en la parte superior te muestra el porcentaje de tareas completadas, motivándote a alcanzar tus metas.

🎨 Diseño Moderno y Atractivo:

Interfaz de usuario limpia y minimalista, siguiendo las directrices de Material Design 3.

Paleta de colores vibrante con un gradiente morado a rosa en el AppBar.

Tipografía personalizada con Google Fonts (Lato) para una lectura agradable.

Animaciones suaves y transiciones fluidas para una experiencia de usuario agradable.

📱 Adaptable y Responsiva: Diseñada para funcionar perfectamente en diferentes tamaños de pantalla y orientaciones.

💬 Feedback Visual: Mensajes SnackBar para confirmar acciones como la eliminación de tareas.

🛠️ Tecnologías Utilizadas
Lenguaje de Programación: Dart

Framework de Desarrollo: Flutter

Persistencia de Datos Local: shared_preferences

Tipografía Personalizada: google_fonts

Diseño UI: Material Design 3

Widgets Clave de Flutter:

StatefulWidget

SharedPreferences

AppBar

FloatingActionButton

ListView.builder

Dismissible

Checkbox

AlertDialog

LinearProgressIndicator

TextEditingController

🚀 Cómo Instalar y Ejecutar
Para poner en marcha Mi Lista de Tareas en tu entorno de desarrollo local, sigue estos sencillos pasos:

Prerrequisitos
Flutter SDK: Se recomienda utilizar la última versión estable.

Un editor de código (como VS Code con la extensión de Flutter) o un IDE (como Android Studio).

Un dispositivo o emulador configurado para ejecutar aplicaciones Flutter (Android, iOS, web o escritorio).

Pasos de Instalación
Clona el repositorio: Abre tu terminal o línea de comandos y ejecuta:

git clone https://github.com/tu_usuario/to_do_list.git
cd to_do_list

(Nota: Reemplaza https://github.com/tu_usuario/to_do_list.git con la URL real de tu repositorio si es diferente).

Instala las dependencias de Flutter: Dentro del directorio del proyecto clonado, ejecuta:

flutter pub get

Esto descargará todas las librerías y paquetes necesarios para el proyecto, incluyendo shared_preferences y google_fonts.

Cómo Ejecutar la Aplicación
Una vez que los pasos de instalación se hayan completado, puedes iniciar la aplicación:

Ejecuta la aplicación:

flutter run

La aplicación se lanzará en el dispositivo o emulador que tengas configurado. Si tienes varios, puedes seleccionar uno con flutter run -d <device_id>.

📈 Cómo Usar la Aplicación
Mi Lista de Tareas es increíblemente fácil de usar. Su diseño intuitivo te permite centrarte en tus tareas, no en cómo usar la aplicación.

Funcionalidades Clave
Añadir una Nueva Tarea:

Haz clic en el botón flotante + (situado en la esquina inferior derecha de la pantalla).

Se abrirá un diálogo donde podrás escribir tu nueva tarea.

Haz clic en "Agregar" para añadirla a tu lista.

Si intentas agregar una tarea vacía, recibirás una notificación.

Marcar/Desmarcar Tareas:

Cada tarea en la lista tiene un Checkbox a su izquierda.

Toca el Checkbox para marcar la tarea como completada (aparecerá tachada) o desmarcarla como pendiente.

El contador de progreso en la parte superior se actualizará automáticamente.

Editar una Tarea:

Toca el icono de lápiz (✏️) a la derecha de cualquier tarea.

Se abrirá un diálogo con el texto actual de la tarea.

Edita el texto y haz clic en "Guardar" para aplicar los cambios.

Eliminar una Tarea:

Para eliminar una tarea, deslízala horizontalmente (hacia la izquierda o hacia la derecha) hasta que desaparezca de la pantalla.

Aparecerá un fondo rojo con un icono de cubo de basura para indicar la eliminación.

Recibirás un mensaje de confirmación (SnackBar) en la parte inferior de la pantalla.

Ver tu Progreso:

En la parte superior de la pantalla, bajo el título, verás un contador que te indica cuántas tareas has completado de un total.

La barra de progreso lineal te dará una representación visual clara de tu avance general.
