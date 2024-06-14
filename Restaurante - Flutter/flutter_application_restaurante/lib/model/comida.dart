import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'comida.g.dart';

@JsonSerializable()
class Comida {
  final int id;
  final String nombre;
  final int id_menu;
  final String precio;
  final String foto;
  final String descripcion;

  Comida(this.id, this.nombre, this.id_menu, this.precio, this.foto,
      this.descripcion);

  // Método de fábrica que crea una instancia de Comida a partir de un mapa JSON.
  factory Comida.fromJson(Map<String, dynamic> json) => _$ComidaFromJson(json);

  // Método que convierte una instancia de Comida a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'idMenu': id_menu,
      'precio': precio,
      'foto': foto ?? '',
      'descripcion': descripcion,
    };
  }
}
