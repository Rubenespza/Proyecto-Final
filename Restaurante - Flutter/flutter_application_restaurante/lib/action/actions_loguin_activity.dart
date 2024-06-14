import 'package:flutter_application_restaurante/util/util.dart';

import '../dialogs/DialogAlert.dart';
import 'package:dio/dio.dart';
import '../controlador/restclient.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Agrega esta línea para importar la biblioteca dart:convert

void iniciarrSesion(String correo, String password, BuildContext context) {
  showProgressDialog("Procesando...", context);

  final dio = Dio(); // Provide a dio instance
  dio.options.headers['Demo-Header'] =
      'demo header'; // config your dio headers globally
  final client = RestClient(dio);

  var response = client.login(correo, password);
  response.then((it) {
    hideProgressDialog(context);

    String responseBody = jsonEncode(it.data);
    print('RESPONSE LOGUIN: ' + responseBody);

    Map<String, dynamic> jsonObject =
        json.decode(responseBody); // Utiliza json.decode aquí
    bool acceso = jsonObject['acceso'];
    String msg = jsonObject['msg'];

    if (acceso) {
      saveData(context, responseBody);
      Navigator.pushReplacementNamed(context, '/principal');
    } else {
      showCloseDialog(msg, context);
    }
  }).catchError((error) {
    print('Error login: $error');

    hideProgressDialog(context);
  });
}
