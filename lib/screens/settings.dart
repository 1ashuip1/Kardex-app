import 'package:flutter/material.dart';
import 'drawer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Pantalla de Configuración'),
      ),
    );
  }
}
