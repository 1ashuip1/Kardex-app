import 'package:flutter/material.dart';

class HistorialDetallado extends StatelessWidget {
  final String estudiante;

  HistorialDetallado({required this.estudiante});

  // Datos simulados de historial (puedes expandirlos)
  final Map<String, List<Map<String, String>>> historialSimulado = {
    'Matemáticas': [
      {'fecha': '2025-03-01', 'anotacion': 'No presentó tarea'},
      {'fecha': '2025-03-05', 'anotacion': 'No hizo examen'},
    ],
    'Ciencias': [
      {'fecha': '2025-03-02', 'anotacion': 'Ausencia sin justificación'},
    ],
    'Historia': [
      {'fecha': '2025-03-04', 'anotacion': 'Tarea incompleta'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de $estudiante'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: historialSimulado.entries.map((entry) {
            final materia = entry.key;
            final anotaciones = entry.value;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ExpansionTile(
                title: Text(
                  materia,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                children: anotaciones.map((anotacion) {
                  return ListTile(
                    title: Text(anotacion['fecha']!),
                    subtitle: Text(anotacion['anotacion']!),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
