import 'package:flutter/material.dart';
import '../ActivityRegistrar.dart';

class Slide3 extends StatelessWidget {
  final TextEditingController nombreLocalController;
  final TextEditingController direccionLocalController;
  final TextEditingController whatsappController;
  final TextEditingController facebookController;

  const Slide3({
    required this.nombreLocalController,
    required this.direccionLocalController,
    required this.whatsappController,
    required this.facebookController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFa854d4), // Cambia al color que necesites
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ic_restaurante.png', // Asegúrate de tener la imagen en la carpeta de activos
                width: 100, // Ajusta el ancho de la imagen según sea necesario
                height:
                    100, // Ajusta la altura de la imagen según sea necesario
              ),
              SizedBox(height: 16), // Espacio entre la imagen y el texto
              Text(
                'Datos del local',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  height:
                      16), // Espacio entre el texto y el primer campo de entrada
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4, // Elevación del card
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nombreLocalController,
                      decoration: InputDecoration(
                        hintText: 'Nombre del local',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio entre los campos de entrada
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4, // Elevación del card
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: direccionLocalController,
                      decoration: InputDecoration(
                        hintText: 'Dirección del local',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio entre los campos de entrada
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4, // Elevación del card
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: whatsappController,
                      decoration: InputDecoration(
                        hintText: 'Whatsapp',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16), // Espacio entre los campos de entrada
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4, // Elevación del card
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: facebookController,
                      decoration: InputDecoration(
                        hintText: 'Facebook',
                        border: OutlineInputBorder(),
                      ),
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

  void validarDatosLocalComercial(BuildContext context) {
    String nombreLocal = nombreLocalController.text.trim();
    String direccionLocal = direccionLocalController.text.trim();
    String whatsapp = whatsappController.text.trim();
    String facebook = facebookController.text.trim();

    if (nombreLocal.isEmpty ||
        direccionLocal.isEmpty ||
        whatsapp.isEmpty ||
        facebook.isEmpty) {
      showError(context, 'Por favor, complete todos los campos');
      return;
    }

    showSuccess(context, 'Datos válidos');
  }
}
