import 'package:flutter/material.dart';
import '../ActivityRegistrar.dart';

class Slide2 extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController apellidoController;
  final TextEditingController domicilioController;

  const Slide2({
    required this.nombreController,
    required this.apellidoController,
    required this.domicilioController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey, // Cambia el color de fondo según sea necesario
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_personal.png', // Asegúrate de tener la imagen en la carpeta de activos
              width: 200, // Ajusta el ancho de la imagen según sea necesario
              height: 200, // Ajusta la altura de la imagen según sea necesario
            ),
            const SizedBox(height: 16), // Espacio entre la imagen y el texto
            const Text(
              'Nombre',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 8), // Espacio entre el texto y el campo de entrada
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 4, // Elevación del card
              child: TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su nombre',
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
                height:
                    16), // Espacio entre el campo de entrada de nombre y el campo de entrada de apellido
            const Text(
              'Apellido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 8), // Espacio entre el texto y el campo de entrada
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 4, // Elevación del card
              child: TextFormField(
                controller: apellidoController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su apellido',
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
                height:
                    16), // Espacio entre el campo de entrada de apellido y el campo de entrada de domicilio
            const Text(
              'Domicilio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 8), // Espacio entre el texto y el campo de entrada
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 4, // Elevación del card
              child: TextFormField(
                controller: domicilioController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su domicilio',
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validarDatosUsuario(BuildContext context) {
    String nombre = nombreController.text.trim();
    String apellido = apellidoController.text.trim();
    String domicilio = domicilioController.text.trim();

    if (nombre.isEmpty || apellido.isEmpty || domicilio.isEmpty) {
      showError(context, 'Por favor, complete todos los campos');
      return;
    }

    showSuccess(context, 'Datos válidos');
  }
}
