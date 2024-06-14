import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_restaurante/dialogs/DialogAlert.dart';
import 'package:flutter_application_restaurante/model/menu.dart';
import 'package:flutter_application_restaurante/model/comida.dart';
import 'package:flutter_application_restaurante/model/registroRequestComida.dart';
import 'package:flutter_application_restaurante/util/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../controlador/restclient.dart';

class NuevoComidaDialog extends StatefulWidget {
  final Menu selectedMenu;

  const NuevoComidaDialog(this.selectedMenu);

  @override
  _NuevoComidaDialogState createState() => _NuevoComidaDialogState();
}

class _NuevoComidaDialogState extends State<NuevoComidaDialog> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  final StringBuffer stringBuffer = new StringBuffer();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
  }

  bool esValido() {
    bool result = true;
    String nombre = nombreController.text.trim();
    String precio = precioController.text.trim();
    String desc = descripcionController.text.trim();

    if (nombre.isEmpty || precio.isEmpty || desc.isEmpty) {
      Fluttertoast.showToast(
        msg: "Complete los campos correctamente...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    }

    if (stringBuffer.isEmpty) {
      Fluttertoast.showToast(
        msg: "Suba una imagen...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    }

    return result;
  }

  Future<void> guardarComida() async {
    if (!esValido()) {
    } else {
      showProgressDialog("Procesando...", context);

      final idMenu = widget.selectedMenu.id;
      final nombre = nombreController.text.trim();
      final descripcion = descripcionController.text.trim();
      final precio = double.tryParse(precioController.text) ?? 0.0;

      File? _imageFile = new File(stringBuffer.toString());
      final bytes = await _imageFile!.readAsBytes();
      String fotoBase64 = base64Encode(bytes);

      final foto = fotoBase64; // Ruta de la imagen seleccionada
      final nombreMenu = widget.selectedMenu.nombre;

      String? jsonString = await getData(context);
      if (jsonString != null) {
        Map<String, dynamic> jsonObject = jsonDecode(jsonString);
        String usuario = jsonObject['usuario'];
        String password = jsonObject['password'];
        int id_restaurante = jsonObject['id_restaurante'];
        final comida =
            Comida(-1, nombre, idMenu, precio.toString(), foto, descripcion);

        final registro = RegistroRequestComida(
          comida: comida,
          id_restaurante:
              id_restaurante, // Ajusta este valor según sea necesario
          menu: nombreMenu,
          usuario: usuario,
          password: password,
        );

        final dio = Dio(); // Provide a dio instance
        dio.options.headers['Demo-Header'] =
            'demo header'; // config your dio headers globally

        final client = RestClient(dio);
        final response = await client.insertar(registro);

        String responseBody = jsonEncode(response.data);
        Map<String, dynamic> map =
            json.decode(responseBody); // Utiliza json.decode aquí
        bool acceso = map['acceso'];
        String msg = map['msg'];

        if (acceso) {
          Fluttertoast.showToast(
            msg: "Comida guardada exitosamente",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          hideProgressDialog(context);
          Navigator.of(context).pop(); // Cerrar el diálogo
        } else {
          Navigator.of(context).pop(); // Cerrar el diálogo

          showCloseDialog(msg, context);
        }
      } else {
        Navigator.of(context).pop(); // Cerrar el diálogo
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        stringBuffer.clear();
        stringBuffer.write(pickedImage.path);
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.pink,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Nuevo ${widget.selectedMenu.nombre}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : AssetImage('assets/plato.png')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.pink,
                          ),
                          child: Text('Seleccionar imagen'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Nombre',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      hintText: 'Nombre del plato',
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Precio',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: precioController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Precio del plato',
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Descripción',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: descripcionController,
                    maxLines: 5,
                    minLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Introduce la descripción aquí',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Acción al presionar el botón Guardar
                          guardarComida();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                        ),
                        child: Text('Guardar'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Acción al presionar el botón Cancelar
                          Navigator.of(context).pop(); // Cerrar el diálogo
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.white,
                        ),
                        child: Text('Cancelar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
