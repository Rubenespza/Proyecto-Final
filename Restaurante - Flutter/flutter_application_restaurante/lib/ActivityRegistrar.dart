import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/ActivityPrincipal.dart';
import 'package:flutter_application_restaurante/controlador/restclient.dart';
import 'package:flutter_application_restaurante/layout/welcome_slide2.dart';
import 'package:flutter_application_restaurante/model/prestador.dart';
import 'package:flutter_application_restaurante/model/registroRequest.dart';
import 'package:flutter_application_restaurante/model/restaurante.dart';
import 'package:flutter_application_restaurante/model/usuario.dart';
import 'package:flutter_application_restaurante/util/util.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'layout/welcome_slide0.dart';
import 'layout/welcome_slide1.dart';
import 'layout/welcome_slide3.dart';
import 'layout/welcome_slide4.dart';

void main() {
  runApp(MaterialApp(home: RegistrarActivity()));
}

class RegistrarActivity extends StatefulWidget {
  @override
  _RegistrarActivityState createState() => _RegistrarActivityState();
}

class _RegistrarActivityState extends State<RegistrarActivity> {
  final PageController _pageController = PageController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _domicilioController = TextEditingController();
  final TextEditingController _nombreLocalController = TextEditingController();
  final TextEditingController _direccionLocalController =
      TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  var stringBuffer = StringBuffer();
  late Slide1 slide1;
  late Slide2 slide2;
  late Slide3 slide3;
  late Slide4 slide4;

  Usuario objUsuario = new Usuario();
  Prestador objPrestador = new Prestador();
  Restaurante objRestaurante = new Restaurante();

  void insertarUsuarioNuevo() async {
    objUsuario.usuario = _usuarioController.text.trim();
    objUsuario.password = _passwordController.text.trim();

    objPrestador.nombre = _nombreController.text.trim();
    objPrestador.apellido = _apellidoController.text.trim();
    objPrestador.direccion = _domicilioController.text.trim();

    objRestaurante.nombre = _nombreLocalController.text.trim();
    objRestaurante.direccion = _direccionLocalController.text.trim();
    objRestaurante.telefono = _whatsappController.text.trim();
    objRestaurante.facebook = _facebookController.text.trim();
    objRestaurante.descripcion = _descripcionController.text.trim();

    File image = new File(stringBuffer.toString());

    String fotoBase64 = '';
    final bytes = await image!.readAsBytes();
    fotoBase64 = base64Encode(bytes);

    objRestaurante.foto = fotoBase64;

    final dio = Dio(); // Provide a dio instance

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Demo-Header'] =
        'demo header'; // config your dio headers globally
    final client = RestClient(dio);

    RegistroRequest registro = new RegistroRequest(
        usuario: objUsuario,
        prestador: objPrestador,
        restaurante: objRestaurante);

    print("objeto imprido: " + registro.toString());

    final response = await client.registrar(registro);
    String responseBody = jsonEncode(response.data);

    Map<String, dynamic> jsonObject =
        json.decode(responseBody); // Utiliza json.decode aquí
    bool acceso = jsonObject['acceso'];

    if (acceso) {
      saveData(context, responseBody);
      // Aqui quiero iniciar otra actividad
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ActivityPrincipal()),
      );
    } else {
      showError(context, "Error: error de registro, reinicie la app.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Slide0(),
              slide1 = Slide1(
                usuarioController: _usuarioController,
                passwordController: _passwordController,
                rePasswordController: _rePasswordController,
              ),
              slide2 = Slide2(
                nombreController: _nombreController,
                apellidoController: _apellidoController,
                domicilioController: _domicilioController,
              ),
              slide3 = Slide3(
                nombreLocalController: _nombreLocalController,
                direccionLocalController: _direccionLocalController,
                whatsappController: _whatsappController,
                facebookController: _facebookController,
              ),
              slide4 = Slide4(
                  descripcionController: _descripcionController,
                  stringBuffer: stringBuffer),
              // Agrega más páginas según sea necesario
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 50.0),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent, // Fondo transparente
                  ),
                  onPressed: () {
                    if (_pageController.page != null &&
                        _pageController.page! < 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      if (!slide1.validarDatosUsuario(context)) {
                      } else {
                        slide1.verificarUsuarioUnicoYSeguir(
                            context, _pageController);
                      }
                      if (_pageController.page == 4) {
                        if (stringBuffer.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Suba una imagen..",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          insertarUsuarioNuevo();
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

void showSuccess(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Éxito'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
