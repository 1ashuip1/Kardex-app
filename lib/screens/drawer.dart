// main.dart
import 'package:flutter/material.dart';
import 'course_screen.dart'; // Importa el nuevo archivo

class CustomDrawer extends StatelessWidget {
  final Map<String, List<String>> materiasCursos = {
    'Física': ['1ro A', '2do C'],
    'Matemáticas': ['1ro B', '3ro A'],
    'Química': ['2do B', '4to C'],
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 242, 248, 253),
                ),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/loading_image.png'),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Usuario',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 24, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Sección de materias con cursos desplegables
                // Opciones generales del Drawer
                _buildDrawerItem(Icons.home, 'Inicio', context, '/home'),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Materias Asignadas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 80, 80, 80),
                    ),
                  ),
                ),
                ...materiasCursos.entries.map((entry) {
                  return _buildMateriaItem(entry.key, entry.value, context);
                }).toList(),
                Divider(),
                _buildDrawerItem(
                    Icons.settings, 'Configuración', context, '/settings'),
                _buildDrawerItem(
                    Icons.logout, 'Cerrar sesión', context, '/login',
                    isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMateriaItem(
      String materia, List<String> cursos, BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.note, color: Colors.blue, size: 28),
      title: Text(materia, style: TextStyle(fontWeight: FontWeight.w500)),
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
      children: cursos.map((curso) {
        return ListTile(
          leading: Icon(Icons.meeting_room, color: Colors.blueAccent, size: 24),
          title: Text(curso),
          contentPadding: EdgeInsets.only(left: 56),
          onTap: () {
            Navigator.pop(context); // Cierra el Drawer
            // Navega a la pantalla del curso pasando materia y curso
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseScreen(
                  materia: materia,
                  curso: curso,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildDrawerItem(
      IconData icon, String title, BuildContext context, String route,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.blue),
      title: Text(title,
          style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      onTap: () {
        Navigator.pop(context);
        if (isLogout) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Kardex Estudiantil')),
      drawer: CustomDrawer(),
      body: Center(child: Text('Pantalla Principal')),
    ),
  ));
}
