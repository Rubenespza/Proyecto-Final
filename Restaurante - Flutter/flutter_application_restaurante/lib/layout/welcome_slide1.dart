import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/dialogs/DialogAlert.dart';
import '../ActivityRegistrar.dart';
import 'package:dio/dio.dart';
import '../controlador/restclient.dart';
import 'dart:convert'; // Agrega esta línea para importar la biblioteca dart:convert

class Slide1 extends StatelessWidget {
  final TextEditingController usuarioController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;

  const Slide1({
    required this.usuarioController,
    required this.passwordController,
    required this.rePasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF14A895), // Color dot_dark_screen2
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  width: 100.0,
                  height: 100.0,
                  image: AssetImage(
                      'assets/ic_user.png'), // Replace with your image path
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Datos de Usuario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                CardViewWithTextInput(
                  controller: usuarioController,
                  hintText: 'Usuario',
                  obscureText: false,
                ),
                SizedBox(height: 10.0),
                CardViewWithTextInput(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                CardViewWithTextInput(
                  controller: rePasswordController,
                  hintText: 'Repetir contraseña',
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validarDatosUsuario(BuildContext context) {
    String us = usuarioController.text.trim();
    String pass = passwordController.text.trim();
    String repass = rePasswordController.text.trim();

    if (pass != repass) {
      showError(context, 'Las contraseñas no coinciden');
      return false;
    }

    if (us.isEmpty || pass.isEmpty || repass.isEmpty) {
      showError(context, 'Por favor, complete todos los campos');
      return false;
    }

    return true;
  }

  void verificarUsuarioUnicoYSeguir(
      BuildContext context, PageController pageController) {
    //showProgressDialog("Verificando usuario...", context);

    final dio = Dio(); // Provide a dio instance
    dio.options.headers['Demo-Header'] =
        'demo header'; // config your dio headers globally
    final client = RestClient(dio);
    String us = usuarioController.text.trim();

    try {
      var response = client.verificarUsuarioExistencia(us);
      response.then((it) {
        String responseBody = jsonEncode(it.data);

        Map<String, dynamic> jsonObject =
            json.decode(responseBody); // Utiliza json.decode aquí
        // Obtener acceso y mensaje del mapa
        bool acceso = jsonObject['acceso'];

        if (acceso) {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          showError(context, "El usuario ya existe, intente otro...");
        }
      }).catchError((error) {
        // Manejar el error
        print('Error de soliticut: $error');
        // Por ejemplo, mostrar un mensaje de error al usuario
      });
    } catch (e) {
      print(e);
    }
  }
}

class CardViewWithTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CardViewWithTextInput({
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          ),
        ),
      ),
    );
  }
}
