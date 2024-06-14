import 'dart:convert';
import 'package:flutter/material.dart';

typedef OnComidaItemClick = void Function(int id_comida);

class ItemComidaWidget extends StatelessWidget {
  final int id_comida;
  final String foto;
  final String nombre;
  final String precio;
  final OnComidaItemClick onClick;

  const ItemComidaWidget({
    required this.id_comida,
    required this.foto,
    required this.nombre,
    required this.precio,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fondo
          Image.asset(
            'assets/bg_item_muestrario.png', // Reemplaza con tu recurso de imagen de fondo
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen de la comida
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(base64Decode(foto)),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 8),
              // Nombre de la comida
              Text(
                nombre,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.pink, // Reemplaza con el color de tu elección
                ),
              ),
              // Precio de la comida
              Text(
                '\$ ' + precio,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.pink, // Reemplaza con el color de tu elección
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              // Botón para eliminar la comida
              GestureDetector(
                onTap: () {
                  onClick(id_comida);
                },
                child: Image.asset(
                  'assets/ic_close.png', // Reemplaza con tu icono de eliminar
                  width: 18,
                  height: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
