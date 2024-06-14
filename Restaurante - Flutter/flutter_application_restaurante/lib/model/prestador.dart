import 'package:json_annotation/json_annotation.dart';

part 'prestador.g.dart';

@JsonSerializable()
class Prestador {
  int id;
  String nombre;
  String apellido;
  String direccion;
  int id_usuario;

  // Constructor de la clase Prestador
  Prestador({
    this.id = -1,
    this.nombre = 'indefinido',
    this.apellido = 'indefinido',
    this.direccion = 'indefinido',
    this.id_usuario = -1,
  });

  // Método de fábrica que crea una instancia de Prestador a partir de un mapa JSON.
  factory Prestador.fromJson(Map<String, dynamic> json) =>
      _$PrestadorFromJson(json);

  // Método que convierte una instancia de Prestador a un mapa JSON.
  Map<String, dynamic> toJson() => _$PrestadorToJson(this);

  // Método toString para imprimir la representación de la clase.
  @override
  String toString() {
    return 'Prestador{id: $id, nombre: $nombre, apellido: $apellido, direccion: $direccion, id_usuario: $id_usuario}';
  }
}
