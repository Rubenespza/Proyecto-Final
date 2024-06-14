import 'package:json_annotation/json_annotation.dart';
import 'usuario.dart';
import 'prestador.dart';
import 'restaurante.dart';

part 'registroDataGeneral.g.dart';

@JsonSerializable()
class RegistroDataGeneral {
  final Usuario usuario;
  final Prestador prestador;
  final Restaurante restaurante;

  // Constructor de la clase RegistroDataGeneral
  RegistroDataGeneral({
    required this.usuario,
    required this.prestador,
    required this.restaurante,
  });

  // Método de fábrica que crea una instancia de RegistroDataGeneral a partir de un mapa JSON.
  factory RegistroDataGeneral.fromJson(Map<String, dynamic> json) =>
      _$RegistroDataGeneralFromJson(json);

  // Método que convierte una instancia de RegistroDataGeneral a un mapa JSON.
  Map<String, dynamic> toJson() => _$RegistroDataGeneralToJson(this);
}
