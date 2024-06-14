import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  int id;
  String nombre;
  String foto;

  // Constructor de la clase Menu
  Menu({
    this.id = -1,
    this.nombre = 'sin menu.',
    this.foto = '',
  });

  // Método de fábrica que crea una instancia de Menu a partir de un mapa JSON.
  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  // Método que convierte una instancia de Menu a un mapa JSON.
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
