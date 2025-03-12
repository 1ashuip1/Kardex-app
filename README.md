# Kardex App - Sistema de Gestión Educativa en Flutter

Este es un proyecto de aplicación móvil desarrollado en **Flutter** para gestionar observaciones, reportes y citaciones de estudiantes en un entorno educativo. La app está diseñada para facilitar el seguimiento del rendimiento y comportamiento de los estudiantes por parte de profesores.

## Funcionalidades

- **Registro de Observaciones:** Permite registrar observaciones y atrasos (como "No presentó tarea", "Ausencia sin justificación") para cada estudiante.
- **Historial Detallado:** Muestra un historial de observaciones por estudiante, organizado por materia y fecha.
- **Generación de Reportes PDF:** Genera reportes en formato PDF con las observaciones registradas.
- **Envío de Citaciones por WhatsApp:** Facilita el envío de citaciones personalizadas a los padres mediante WhatsApp, con fecha y hora editables.
- **Búsqueda de Estudiantes:** Incluye un buscador para encontrar estudiantes rápidamente.
- **Soporte Offline (Pendiente):** Guarda datos localmente y sincroniza con una base de datos remota cuando haya conexión (funcionalidad en desarrollo).

## Tecnologías Utilizadas

- **Flutter** y **Dart**: Para el desarrollo de la interfaz y lógica de la app.
- **Paquetes de Flutter:**
  - `http`: Para conexión con API (en desarrollo).
  - `url_launcher`: Para enviar citaciones por WhatsApp.
  - `pdf` y `open_file`: Para generar y abrir reportes PDF.
  - `connectivity_plus`: Para verificar la conexión a internet (en desarrollo).
- **Base de Datos (Futuro):** Integración planificada con Firebase o MySQL mediante una API REST.

## Cómo Usar

### Requisitos Previos

- Tener instalado **Flutter** y **Dart** en tu máquina. Sigue [esta guía de instalación de Flutter](https://flutter.dev/docs/get-started/install) si no lo tienes.
- Tener **Android Studio** o **VSCode** configurado para Flutter.
- Un dispositivo Android/iOS o un emulador/simulador para probar la app.

### Instalación

1. **Clona el Repositorio:**
   ```bash
   git clone https://github.com/1ashuip1/Kardex-app.git
Navega al Directorio del Proyecto:
bash

Contraer

Ajuste

Copiar
cd Kardex-app
Instala las Dependencias:
bash

Contraer

Ajuste

Copiar
flutter pub get
Conecta un Dispositivo o Emulador:
Conecta un dispositivo Android/iOS o inicia un emulador desde Android Studio/VSCode.
Ejecuta el Proyecto:
bash

Contraer

Ajuste

Copiar
flutter run
Acceso a la Aplicación
La aplicación incluye credenciales provisionales para pruebas. Usa las siguientes credenciales para iniciar sesión como administrador:

Usuario: admin@gmail.com
Contraseña: admin
Nota: Estas son credenciales de prueba. Para un entorno de producción, se recomienda implementar un sistema de autenticación seguro (como Firebase Authentication) y cambiar estas credenciales.

Estructura del Proyecto
lib/: Contiene el código fuente en Flutter.
main.dart: Punto de entrada de la aplicación.
course_screen.dart: Pantalla principal para gestionar observaciones, reportes y citaciones.
historial_estudiante.dart: Pantalla para buscar estudiantes y ver su historial.
historial_detallado.dart: Pantalla para mostrar el historial detallado por materia y fecha.
assets/: Carpeta para imágenes, iconos y otros recursos (actualmente vacía, pero puedes añadirlos).
android/: Configuraciones específicas para Android.
ios/: Configuraciones específicas para iOS (si planeas compilar para iOS).
pubspec.yaml: Archivo de configuración de dependencias.
Contribuir
Haz un fork del repositorio.
Crea una rama para tu nueva funcionalidad (git checkout -b feature/nueva-funcionalidad).
Haz tus cambios y confirma (git commit -m "Añadir nueva funcionalidad").
Sube tus cambios (git push origin feature/nueva-funcionalidad).
Crea un Pull Request en GitHub.
Notas Adicionales
Estado Actual: La app está en desarrollo. Algunas funcionalidades (como soporte offline y conexión a base de datos remota) están en proceso de implementación.
Siguientes Pasos: Integrar Firebase o una API REST para almacenar datos remotamente, y mejorar la interfaz de usuario con autenticación segura.
Contacto
Si tienes preguntas o sugerencias, puedes contactarme a través de GitHub: 1ashuip1.
