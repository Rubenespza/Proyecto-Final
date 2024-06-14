import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/controlador/restclient.dart';
import 'package:flutter_application_restaurante/dialogs/DialogAlert.dart';
import 'package:flutter_application_restaurante/model/registroDataGeneral.dart';
import 'package:flutter_application_restaurante/util/util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogEdicion extends StatefulWidget {
  final RegistroDataGeneral registro;

  DialogEdicion({required this.registro});

  @override
  _DialogEdicionState createState() => _DialogEdicionState();
}

class _DialogEdicionState extends State<DialogEdicion> {
  late TextEditingController _nombreComercioController;
  late TextEditingController _descripcionController;
  late TextEditingController _passwordController;
  late TextEditingController _nombrePropController;
  late TextEditingController _apellidoPropController;

  @override
  void initState() {
    super.initState();
    _nombreComercioController =
        TextEditingController(text: widget.registro.restaurante.nombre);
    _descripcionController =
        TextEditingController(text: widget.registro.restaurante.descripcion);
    _passwordController =
        TextEditingController(text: widget.registro.usuario.password);
    _nombrePropController =
        TextEditingController(text: widget.registro.prestador.nombre);
    _apellidoPropController =
        TextEditingController(text: widget.registro.prestador.apellido);
  }

  @override
  void dispose() {
    _nombreComercioController.dispose();
    _descripcionController.dispose();
    _passwordController.dispose();
    _nombrePropController.dispose();
    _apellidoPropController.dispose();
    super.dispose();
  }

  Future<void> _actualizarDatos() async {
    widget.registro.restaurante.nombre = _nombreComercioController.text.trim();
    widget.registro.restaurante.descripcion =
        _descripcionController.text.trim();

    widget.registro.usuario.password = _passwordController.text.trim();

    widget.registro.prestador.nombre = _nombrePropController.text.trim();
    widget.registro.prestador.apellido = _apellidoPropController.text.trim();

    // Mostrar un diálogo de progreso
    showProgressDialog("Procesando....", context);
    final dio = Dio(); // Provide a dio instance
    dio.options.headers['Demo-Header'] =
        'demo header'; // config your dio headers globally

    final client = RestClient(dio);
    final response = await client.actualizarTablas(widget.registro);

    Map<String, dynamic> map = response.data;
    bool acceso = map["acceso"];
    String msg = map["msg"];
    if (acceso) {
      Fluttertoast.showToast(
        msg: "Perfil actualizado!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      String? datos = await getData(context);

      if (datos != null) {
        print("datos viejos: " + datos);

        Map<String, dynamic> map = jsonDecode(datos);
        // Actualiza el valor de la clave "password" con el nuevo valor
        map.update("password", (value) => widget.registro.usuario.password,
            ifAbsent: () => widget.registro.usuario.password);

        // Opcional: puedes convertir el map de nuevo a JSON si es necesario
        String updateDatos = jsonEncode(map);
        print("datos nuevos: " + updateDatos);
        saveData(context, updateDatos);
      }
      Navigator.of(context).pop();
    } else {
      showCloseDialog(msg, context);
    }
    hideProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Editar Restaurante",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildTextField(_nombreComercioController, "Nombre del comercio"),
            _buildTextField(_descripcionController, "Descripción"),
            _buildTextField(_passwordController, "Contraseña",
                obscureText: false),
            _buildTextField(_nombrePropController, "Nombre del propietario"),
            _buildTextField(
                _apellidoPropController, "Apellido del propietario"),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: _actualizarDatos,
                  child: Text("Guardar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildImage(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return Container(
        height: 150,
        width: double.infinity,
        color: Colors.grey[200],
        child: Icon(Icons.image, size: 100, color: Colors.grey[400]),
      );
    } else {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(bytes,
          height: 150, width: double.infinity, fit: BoxFit.cover);
    }
  }
}
