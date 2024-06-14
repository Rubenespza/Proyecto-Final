import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_restaurante/model/menu.dart';

typedef OnMenuItemClick = void Function(Menu menu);

class MenuItemWidget extends StatelessWidget {
  final Menu menu; // Asume que cada menú tiene un ID
  final OnMenuItemClick onClick;

  const MenuItemWidget({
    required this.menu,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    // Decodificar la cadena Base64 a bytes
    List<int> bytes = base64Decode(menu.foto);

    // Convertir la lista de bytes a Uint8List
    Uint8List uint8list = Uint8List.fromList(bytes);

    return GestureDetector(
      onTap: () => onClick(menu), // Llama al callback cuando se toca el widget

      child: Container(
        width: 150, // Ajusta esta anchura según sea necesario
        margin: EdgeInsets.only(right: 1),
        decoration: BoxDecoration(
          color: Colors.transparent, // Reemplaza con el diseño de tu item
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/bg_item.png', // Reemplaza con tu recurso de imagen de fondo
              fit: BoxFit
                  .fill, // Para que la imagen llene todo el espacio disponible
              width: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(
                  uint8list, // Utiliza los bytes decodificados (convertidos a Uint8List) para mostrar la imagen
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8),
                Text(
                  menu.nombre,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.pink, // Reemplaza con el color de tu elección
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
