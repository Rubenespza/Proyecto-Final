import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/ActivityPrincipal.dart';
import 'action/actions_loguin_activity.dart';
import 'ActivityRegistrar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        '/registrar': (context) => MaterialApp(
              home: RegistrarActivity(),
            ),
        '/principal': (context) => MaterialApp(
              home: ActivityPrincipal(),
            )
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  // Define los controladores de texto
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_general.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
                width: double.infinity,
                height: 350.0,
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg_card.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/user.png',
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 5.0),
                      const Text(
                        'Usuario',
                        style: TextStyle(
                          color: Colors.cyan, // Assuming celeste is cyan
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        controller: usuarioController, // Asigna el controlador
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      const Text(
                        'Contraseña',
                        style: TextStyle(
                          color: Colors.cyan, // Assuming celeste is cyan
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        controller:
                            contrasenaController, // Asigna el controlador
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Obtén los valores de los controladores
                          String usuario = usuarioController.text;
                          String contrasena = contrasenaController.text;
                          iniciarrSesion(usuario, contrasena, context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, 50.0), // Match parent width
                        ),
                        child: Text('Entrar'),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          // Navegar a la pantalla RegistrarActivity
                          Navigator.pushNamed(context, '/registrar');
                        },
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            color: Colors.cyan, // Assuming celeste is cyan
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
