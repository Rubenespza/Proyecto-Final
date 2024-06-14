import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Slide4 extends StatefulWidget {
  final TextEditingController? descripcionController;
  final StringBuffer stringBuffer;

  const Slide4({
    required this.descripcionController,
    required this.stringBuffer,
  });

  @override
  _Slide4State createState() => _Slide4State();
}

class _Slide4State extends State<Slide4> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.stringBuffer.clear();
        widget.stringBuffer.write(pickedFile.path);
        _image = new File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFa854d4), // Cambia al color que necesites
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200, // Ajusta el ancho de la imagen
                height: 200, // Ajusta la altura de la imagen
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _image != null
                        ? FileImage(_image!)
                        : AssetImage('assets/ic_restaurante.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF000000), // Color del botón, ajustar según sea necesario
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                child: Text(
                  'Cargar foto',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4, // Elevación del card
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: widget.descripcionController,
                      decoration: InputDecoration(
                        hintText: 'Descripcion...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      minLines: 4,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                    ),
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
