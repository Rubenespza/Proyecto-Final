import 'package:flutter_application_restaurante/model/comida.dart';
import 'package:flutter_application_restaurante/model/menu.dart';
import 'package:flutter_application_restaurante/util/util.dart';
import 'package:dio/dio.dart';
import '../controlador/restclient.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Agrega esta línea para importar la biblioteca dart:convert

Future<List<Menu>> cargarMenus(BuildContext context) async {
  final dio = Dio(); // Provide a dio instance
  dio.options.headers['Demo-Header'] =
      'demo header'; // config your dio headers globally
  final client = RestClient(dio);

  int id_restaurante = -1;
  String? jsonString = await getData(context);
  if (jsonString != null) {
    Map<String, dynamic> jsonObject = jsonDecode(jsonString);
    id_restaurante = jsonObject['id_restaurante'];

    print("id_rest: $id_restaurante");
  }

  try {
    final response = await client.obtenerMenus();
    String responseBody = jsonEncode(response.data);

    final List<dynamic> decodedJson = jsonDecode(responseBody);
    final List<Menu> menuList =
        decodedJson.map((json) => Menu.fromJson(json)).toList();

    return menuList;
  } catch (error) {
    // Manejar el error
    print('Error de backend: $error');
    return [];
  }
}

Future<List<Comida>> obtenerComidas(
    BuildContext context, int id_menu, String nombre) async {
  final dio = Dio(); // Provide a dio instance
  dio.options.headers['Demo-Header'] =
      'demo header'; // config your dio headers globally
  final client = RestClient(dio);

  int id_restaurante = -1;
  String? jsonString = await getData(context);
  if (jsonString != null) {
    Map<String, dynamic> jsonObject = jsonDecode(jsonString);
    id_restaurante = jsonObject['id_restaurante'];
  }

  try {
    final response = await client.obtenerMuestrario(id_menu, id_restaurante);

    String responseBody = jsonEncode(response.data);

    final List<dynamic> decodedJson = jsonDecode(responseBody);
    final List<Comida> comidas =
        decodedJson.map((json) => Comida.fromJson(json)).toList();

    return comidas;
  } catch (error) {
    print('Error de backend obtenerComidas: $error');
    return [];
  }
}

Future<void> eliminarComida(int id_comida) async {
  final dio = Dio(); // Provide a dio instance
  dio.options.headers['Demo-Header'] =
      'demo header'; // config your dio headers globally
  final client = RestClient(dio);

  try {
    final response = await client.eliminarComida(id_comida);
    String responseBody = jsonEncode(response.data);

    print("eliminarComida: " + responseBody);
  } catch (error) {
    // Manejar el error
    print('Error de backend eliminarComida: $error');
  }
}
