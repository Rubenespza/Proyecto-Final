import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_restaurante/dialogs/dialog_editar_restaurante.dart';
import 'package:flutter_application_restaurante/model/registroDataGeneral.dart';

import '../dialogs/DialogAlert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/controlador/restclient.dart';
import 'package:flutter_application_restaurante/model/restaurante.dart';

import '../util/util.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Restaurante restaurante = new Restaurante();

  @override
  void initState() {
    super.initState();
    cargarInformacionPerfil();
  }

  Future<void> abrirDialogEdicion() async {
    String? jsonString = await getData(context);

    if (jsonString != null) {
      Map<String, dynamic> jsonObject = jsonDecode(jsonString);
      String usuario = jsonObject['usuario'];
      String password = jsonObject['password'];
      final dio = Dio(); // Provide a dio instance
      dio.options.headers['Demo-Header'] =
          'demo header'; // config your dio headers globally

      final client = RestClient(dio);
      final response = await client.obtenerDatosGeneral(usuario, password);
      Map<String, dynamic> map = response.data;
      String json_rg = map["obj"];
      Map<String, dynamic> rgMap = jsonDecode(json_rg);
      RegistroDataGeneral obj = RegistroDataGeneral.fromJson(rgMap);

      print("tostring: " + obj.toString());

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogEdicion(registro: obj);
        },
      );
    }
  }

  Future<void> cargarInformacionPerfil() async {
    String? jsonString = await getData(context);
    if (jsonString != null) {
      Map<String, dynamic> jsonObject = jsonDecode(jsonString);
      String usuario = jsonObject['usuario'];
      String password = jsonObject['password'];
      int id_restaurante = jsonObject['id_restaurante'];

      final dio = Dio(); // Provide a dio instance
      dio.options.headers['Demo-Header'] =
          'demo header'; // config your dio headers globally

      final client = RestClient(dio);
      final response = await client.obtenerDatosRestaurante(
          usuario, password, id_restaurante);

      Map<String, dynamic> map =
          json.decode(response.data); // Utiliza json.decode aquí
      String json_restaurante = map['msg'];
      Map<String, dynamic> restauranteMap = jsonDecode(json_restaurante);
      Restaurante obj = Restaurante.fromJson(restauranteMap);

      restaurante = obj;
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bg_home.png'), // Cambia al fondo correspondiente
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Card(
                    color: Color(0x88FFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            child: Image.memory(
                              base64Decode(restaurante.foto),
                              width: double.infinity,
                              height: 300.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildInfoRow(
                                    'Local comercial: ', restaurante.nombre),
                                buildDivider(),
                                buildInfoRow(
                                    'Dirección: ', restaurante.direccion),
                                buildDivider(),
                                buildInfoRow(
                                    'Teléfono: ', restaurante.telefono),
                                buildDivider(),
                                buildInfoRow(
                                    'Facebook: ', restaurante.facebook),
                                buildDivider(),
                                buildInfoColumn(
                                    'Descripción: ', restaurante.descripcion),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        // Acción al presionar el botón Editar
                        abrirDialogEdicion();
                      },
                      backgroundColor: Color(0xFF00BCD4),
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String content) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoColumn(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 1.0,
      color: Color(0xFFb5b2b2),
    );
  }
}
