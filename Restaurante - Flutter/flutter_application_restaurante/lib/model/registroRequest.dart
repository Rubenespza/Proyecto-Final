import 'package:json_annotation/json_annotation.dart';
import 'usuario.dart';
import 'prestador.dart';
import 'restaurante.dart';

part 'registroRequest.g.dart';

// Agregar la anotación @JsonSerializable()
@JsonSerializable()
class RegistroRequest {
  final Usuario usuario;
  final Prestador prestador;
  final Restaurante restaurante;

  // Constructor de la clase RegistroRequest
  RegistroRequest({
    required this.usuario,
    required this.prestador,
    required this.restaurante,
  });

  // Método de fábrica que crea una instancia de RegistroRequest a partir de un mapa JSON.
  factory RegistroRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistroRequestFromJson(json);

  // Método que convierte una instancia de RegistroRequest a un mapa JSON.
  Map<String, dynamic> toJson() => _$RegistroRequestToJson(this);

  @override
  String toString() {
    return 'RegistroRequest{usuario: $usuario, prestador: $prestador, restaurante: $restaurante}';
  }
}
