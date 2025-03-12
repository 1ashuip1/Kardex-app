import 'package:flutter/material.dart';
import 'login.dart'; // Asegúrate de importar login.dart para la navegación

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Temporizador de 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      // Verifica si el widget aún está montado antes de navegar
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: Center(
        child: SizedBox(
          width: 150, // Ancho de la imagen
          height: 150, // Alto de la imagen
          child: Image.asset(
            'assets/images/loading_image.png',
            fit: BoxFit.contain, // Ajusta la imagen sin deformarla
          ),
        ),
      ),
    );
  }
}
