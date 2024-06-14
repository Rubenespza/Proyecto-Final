import 'package:json_annotation/json_annotation.dart';
import 'comida.dart';

part 'registroRequestComida.g.dart';

@JsonSerializable()
class RegistroRequestComida {
  final Comida comida;
  final int id_restaurante;
  final String menu;
  final String usuario;
  final String password;

  // Constructor de la clase RegistroRequestComida
  RegistroRequestComida({
    required this.comida,
    required this.id_restaurante,
    required this.menu,
    required this.usuario,
    required this.password,
  });

  // Método de fábrica que crea una instancia de RegistroRequestComida a partir de un mapa JSON.
  factory RegistroRequestComida.fromJson(Map<String, dynamic> json) =>
      _$RegistroRequestComidaFromJson(json);

  // Método que convierte una instancia de RegistroRequestComida a un mapa JSON.
  Map<String, dynamic> toJson() => _$RegistroRequestComidaToJson(this);
}
