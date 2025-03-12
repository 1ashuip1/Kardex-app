import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseScreen extends StatefulWidget {
  final String materia;
  final String curso;

  CourseScreen({required this.materia, required this.curso});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final List<String> estudiantes = [
    'Juan Pérez',
    'María Gómez',
    'Carlos López',
    'Ana Martínez',
    'Luis Rodríguez',
  ];
  List<String> estudiantesFiltrados = [];
  TextEditingController _searchController = TextEditingController();

  // Mapa para almacenar múltiples registros por estudiante (lista de registros)
  Map<String, List<Map<String, String>>> registros = {};

  // Mapa simulado de números de teléfono de los padres (para la citación)
  final Map<String, String> telefonosPadres = {
    'Juan Pérez': '+59168180719',
    'María Gómez': '+59168180719',
    'Carlos López': '+59168180719',
    'Ana Martínez': '+59168180719',
    'Luis Rodríguez': '+59168180719',
  };

  @override
  void initState() {
    super.initState();
    estudiantesFiltrados = estudiantes;
    _searchController.addListener(_filtrarEstudiantes);
    // Inicializar el mapa con listas vacías para cada estudiante
    for (var estudiante in estudiantes) {
      registros[estudiante] = [];
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filtrarEstudiantes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      estudiantesFiltrados = estudiantes
          .where((estudiante) => estudiante.toLowerCase().contains(query))
          .toList();
    });
  }

  // Modal inicial para el estudiante
  void _mostrarModalEstudiante(BuildContext context, String estudiante) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Detalles de $estudiante',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Materia: ${widget.materia}'),
              Text('Curso: ${widget.curso}'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _mostrarFormularioRegistro(context, estudiante);
                    },
                    child: Text('Registrar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Modal con formulario para registrar atrasos y observaciones (múltiples selecciones)
  void _mostrarFormularioRegistro(BuildContext context, String estudiante) {
    List<String> atrasosSeleccionados = [];
    TextEditingController observacionesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Registrar para $estudiante',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text('Selecciona los atrasos (puedes elegir más de uno):'),
                SizedBox(
                  height: 200, // Ajusta la altura para mostrar más casillas
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ...[
                        'Felicitacion',
                        'No entregó tarea',
                        'Tarea incompleta',
                        'No presentó examen',
                        'Ausencia sin justificación',
                        'No participó',
                        'Problemas de puntualidad',
                        'No trajo material',
                        'No respetó normas',
                        'Distracción en clase',
                        'Falta de respeto',
                        'Actitud negativa',
                        'Desordenado/a',
                        'Problemas de comportamiento',
                        'Falta de concentración',
                        'Ausencia repetida',
                        'No cumplió con reglas del uniforme'
                      ].map((String atraso) {
                        return CheckboxListTile(
                          title: Text(atraso),
                          value: atrasosSeleccionados.contains(atraso),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                atrasosSeleccionados.add(atraso);
                              } else {
                                atrasosSeleccionados.remove(atraso);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: observacionesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Observaciones',
                    border: OutlineInputBorder(),
                    hintText: 'Escribe observaciones aquí...',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String atrasos = atrasosSeleccionados.isEmpty
                            ? 'No especificado'
                            : atrasosSeleccionados.join(', ');
                        String observaciones =
                            observacionesController.text.isEmpty
                                ? 'Sin observaciones'
                                : observacionesController.text;
                        setState(() {
                          registros[estudiante]!.add({
                            'atrasos': atrasos,
                            'observaciones': observaciones,
                          });
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Guardado: $estudiante - Atrasos: $atrasos, Observaciones: $observaciones'),
                          ),
                        );
                      },
                      child: Text('Guardar'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal para mostrar el historial de observaciones con opción de eliminar
  void _mostrarHistorialObservaciones(BuildContext context, String estudiante) {
    final historial = registros[estudiante] ?? [];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Historial de Observaciones de $estudiante',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              if (historial.isEmpty)
                Text('No hay registros para este estudiante.')
              else
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: historial.length,
                    itemBuilder: (context, index) {
                      final registro = historial[index];
                      return ListTile(
                        title: Text('Atrasos: ${registro['atrasos']}'),
                        subtitle:
                            Text('Observaciones: ${registro['observaciones']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              historial.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registro eliminado')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Modal para editar y enviar citación
  Future<void> _enviarCitacion(String estudiante) async {
    TextEditingController mensajeController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Citación para los padres de $estudiante',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: mensajeController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Mensaje',
                    border: OutlineInputBorder(),
                    hintText:
                        'Escribe el mensaje de citación aquí... (por ejemplo, motivo de la citación)',
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text('Fecha: ${selectedDate.toLocal()}'.split(' ')[0]),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                  },
                ),
                ListTile(
                  title: Text('Hora: ${selectedTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (picked != null && picked != selectedTime)
                      setState(() {
                        selectedTime = picked;
                      });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final numeroTelefono = telefonosPadres[estudiante];
                    if (numeroTelefono == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'No se encontró el número de los padres de $estudiante')),
                      );
                      return;
                    }

                    final mensaje = mensajeController.text.isEmpty
                        ? 'Estimados padres de $estudiante, se solicita su presencia para una citación el ${selectedDate.toLocal()} a las ${selectedTime.format(context)} debido a observaciones registradas en la materia ${widget.materia} del curso ${widget.curso}. Por favor, contáctenos para coordinar.'
                        : mensajeController.text;
                    final url =
                        'https://wa.me/$numeroTelefono?text=${Uri.encodeFull(mensaje)}';

                    if (await canLaunch(url)) {
                      await launch(url);
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No se pudo abrir WhatsApp')),
                      );
                    }
                  },
                  child: Text('Enviar Citación por WhatsApp'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // Función para generar el reporte en PDF
  Future<void> _generarReportePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Reporte: ${widget.materia} - ${widget.curso}',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Lista de Estudiantes y Observaciones',
                  style: pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: [
                  'Estudiante',
                  'Último Atraso',
                  'Últimas Observaciones'
                ],
                data: estudiantes.map((estudiante) {
                  final ultimoRegistro =
                      registros[estudiante]?.isNotEmpty == true
                          ? registros[estudiante]!.last
                          : {
                              'atrasos': 'Ninguno',
                              'observaciones': 'Sin observaciones'
                            };
                  return [
                    estudiante,
                    ultimoRegistro['atrasos']!,
                    ultimoRegistro['observaciones']!,
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    // Guardar el PDF en el dispositivo
    final directory = await getExternalStorageDirectory();
    final file = File("${directory!.path}/reporte_${widget.curso}.pdf");
    await file.writeAsBytes(await pdf.save());

    // Mostrar mensaje y abrir el archivo (opcional)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reporte guardado en ${file.path}')),
    );
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.materia} - ${widget.curso}'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Botón para generar reporte
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _generarReportePDF,
              child: Text('Generar Reporte'),
            ),
          ),
          // Buscador
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar estudiante...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: estudiantesFiltrados.length,
              itemBuilder: (context, index) {
                final estudiante = estudiantesFiltrados[index];
                return ListTile(
                  leading: Icon(Icons.person, color: Colors.blueAccent),
                  title: Text(estudiante),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botón de Historial
                      GestureDetector(
                        onTap: () {
                          _mostrarHistorialObservaciones(context, estudiante);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.list_alt, // Icono de lista para historial
                              color: Colors.blue,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Historial',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16), // Espacio entre botones
                      // Botón de Citación
                      GestureDetector(
                        onTap: () {
                          _enviarCitacion(estudiante);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone, // Icono de teléfono para citación
                              color: Colors.green,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Citación',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    _mostrarModalEstudiante(context, estudiante);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
