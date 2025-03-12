import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home.dart';
import 'historial.dart'; // Asegúrate de importar la nueva pantalla

const users = {
  'usuario@gmail.com': '12345',
  'admin@gmail.com': 'admin',
};

class Login extends StatelessWidget {
  const Login({super.key});

  Duration get loginTime => const Duration(milliseconds: 500);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Usuario: ${data.name}, Contraseña: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Usuario no existe';
      }
      if (users[data.name] != data.password) {
        return 'Contraseña incorrecta';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Registro Usuario: ${data.name}, Contraseña: ${data.password}');
    return Future.delayed(loginTime).then((_) => null);
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Recuperar contraseña de: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Usuario no existe';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400 || screenHeight < 600;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          FlutterLogin(
            logo: const AssetImage('assets/images/logo.png'),
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Home(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            onRecoverPassword: _recoverPassword,
            messages: LoginMessages(
              userHint: 'Correo electrónico',
              passwordHint: 'Contraseña',
              confirmPasswordHint: 'Confirmar contraseña',
              loginButton: 'Iniciar sesión',
              signupButton: 'Registrarse',
              recoverPasswordButton: 'Recuperar contraseña',
              recoverPasswordIntro: 'Recupera tu cuenta',
              recoverPasswordDescription:
                  'Ingresa tu correo electrónico para recibir un enlace de recuperación.',
              goBackButton: 'Volver',
              flushbarTitleError: 'Error',
              flushbarTitleSuccess: 'Éxito',
              forgotPasswordButton: '¿Olvidó su Contraseña?',
            ),
            theme: LoginTheme(
              primaryColor: Color.fromARGB(255, 80, 80, 80),
              accentColor: const Color.fromARGB(255, 80, 80, 80),
              errorColor: Colors.deepOrange,
              titleStyle: const TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'Quicksand',
                letterSpacing: 4,
              ),
              bodyStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
              textFieldStyle: const TextStyle(
                color: Colors.orange,
                shadows: [
                  Shadow(color: Color.fromARGB(255, 0, 0, 0), blurRadius: 2)
                ],
              ),
              buttonStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              cardTheme: CardTheme(
                color: Colors.yellow.shade100,
                elevation: 5,
                margin: const EdgeInsets.only(top: 15),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
              ),
              inputTheme: InputDecorationTheme(
                filled: true,
                fillColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(.1),
                contentPadding: EdgeInsets.zero,
                errorStyle: const TextStyle(
                  backgroundColor: Color.fromARGB(255, 255, 249, 196),
                  color: Color.fromARGB(255, 255, 87, 34),
                ),
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 50, 50, 50),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 50, 50, 50), width: 4),
                  borderRadius: inputBorder,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 200, 200, 200),
                      width: 5),
                  borderRadius: inputBorder,
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade700, width: 7),
                  borderRadius: inputBorder,
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400, width: 8),
                  borderRadius: inputBorder,
                ),
                disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 5),
                  borderRadius: inputBorder,
                ),
              ),
              buttonTheme: LoginButtonTheme(
                splashColor: const Color.fromARGB(255, 0, 0, 0),
                backgroundColor: const Color.fromARGB(255, 150, 150, 150),
                highlightColor: const Color.fromARGB(255, 255, 249, 196),
                elevation: 9.0,
                highlightElevation: 6.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: isSmallScreen ? 5 : 16,
                horizontal: isSmallScreen ? 5 : 16,
              ),
              color: const Color.fromARGB(255, 80, 80, 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                      height: 10), // Espacio entre el texto y el botón
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: isSmallScreen
                            ? 20
                            : 50), // Mueve el botón hacia arriba
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navega a la pantalla HistorialEstudiante
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistorialEstudiante(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search, color: Colors.black),
                      label: Text(
                        'Historial del Estudiante',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen
                              ? 12
                              : 16, // Reduce el tamaño del texto en pantallas pequeñas
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 10 : 16,
                          horizontal: isSmallScreen ? 15 : 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '© 2025 V.1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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
