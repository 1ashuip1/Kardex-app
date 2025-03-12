import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Importa el reproductor de YouTube
import 'drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          // Fondo de pantalla
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 220, 220, 220),
                  Color.fromARGB(255, 220, 220, 220)
                ],
              ),
            ),
          ),

          // Contenido centrado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape
                        .circle, // Asegúrate de que tenga forma circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.3), // Sombra negra con opacidad
                        blurRadius: 10, // Radio de desenfoque de la sombra
                        offset: const Offset(0,
                            4), // Desplazamiento de la sombra (horizontal, vertical)
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(
                    height:
                        20), // Aumenté el espacio entre la imagen y el texto
                const Text(
                  '¡Hola, Usuario!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 80, 80),
                  ),
                ),
                const Text(
                  'Bienvenido de nuevo 🎉',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 80, 80, 80),
                  ),
                ),
              ],
            ),
          ),

          // Logo de YouTube en la esquina inferior derecha
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Redirigir a la página de video
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  FaIcon(FontAwesomeIcons.youtube, color: Colors.red, size: 30),
                  const SizedBox(width: 5),
                  const Text(
                    'Tutoriales',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller1 = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ', // Cambia por tu ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(_onPlayerStateChange);

    _controller2 = YoutubePlayerController(
      initialVideoId: 'snFhcHHdzT0', // Cambia por tu ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(_onPlayerStateChange);
  }

  void _onPlayerStateChange() {
    // Detecta si algún controlador entra o sale de pantalla completa
    if (_controller1.value.isFullScreen || _controller2.value.isFullScreen) {
      if (!_isFullScreen) {
        setState(() {
          _isFullScreen = true;
        });
      }
    } else if (_isFullScreen) {
      setState(() {
        _isFullScreen = false;
      });
    }
  }

  @override
  void dispose() {
    _controller1.removeListener(_onPlayerStateChange);
    _controller2.removeListener(_onPlayerStateChange);
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null // Oculta el AppBar en pantalla completa
          : AppBar(
              title: const Text('Tutoriales'),
              backgroundColor: const Color.fromARGB(255, 80, 80, 80),
            ),
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      body: _isFullScreen
          ? YoutubePlayer(
              controller:
                  _controller1.value.isFullScreen ? _controller1 : _controller2,
              showVideoProgressIndicator: true,
              progressIndicatorColor: _controller1.value.isFullScreen
                  ? Colors.blueAccent
                  : Colors.redAccent,
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: YoutubePlayer(
                          controller: _controller1,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Anotación',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: YoutubePlayer(
                          controller: _controller2,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
