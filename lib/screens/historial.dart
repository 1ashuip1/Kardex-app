import 'package:flutter/material.dart';
import 'historial_detallado.dart'; // Importamos la nueva pantalla

class HistorialEstudiante extends StatefulWidget {
  const HistorialEstudiante({super.key});

  @override
  State<HistorialEstudiante> createState() => _HistorialEstudianteState();
}

class _HistorialEstudianteState extends State<HistorialEstudiante> {
  TextEditingController _controller = TextEditingController();
  List<String> estudiantes = [
    'Juan Pérez',
    'María Gómez',
    'Carlos López',
    'Ana Martínez',
    'Luis Rodríguez',
  ];
  List<String> resultados = []; // Para almacenar los resultados de la búsqueda

  @override
  void initState() {
    super.initState();
    resultados = []; // Inicialmente vacía, no muestra estudiantes
  }

  // Función para buscar estudiante exacto
  void buscarEstudiante() {
    String query = _controller.text.trim();
    setState(() {
      resultados.clear();
      if (query.isNotEmpty) {
        // Busca coincidencia exacta (ignorando mayúsculas/minúsculas)
        for (var estudiante in estudiantes) {
          if (estudiante.toLowerCase() == query.toLowerCase()) {
            resultados.add(estudiante);
            break; // Sale del bucle al encontrar la primera coincidencia exacta
          }
        }
      }
      // Si no hay coincidencia, resultados permanece vacío
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial del Estudiante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para búsqueda
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Buscar estudiante',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón para buscar
            ElevatedButton(
              onPressed: buscarEstudiante,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            // Lista de estudiantes filtrados (solo aparece después de buscar)
            if (resultados.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: resultados.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(resultados[index]),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navegar a la pantalla de historial detallado
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistorialDetallado(
                                estudiante: resultados[index],
                              ),
                            ),
                          );
                        },
                        child: const Text('Historial'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else if (resultados.isEmpty && _controller.text.isNotEmpty) ...[
              const Text('No se encontró el estudiante.'),
            ],
          ],
        ),
      ),
    );
  }
}
