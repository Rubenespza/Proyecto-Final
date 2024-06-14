// Definición de la clase Restaurante en Dart
import 'package:json_annotation/json_annotation.dart';

part 'restaurante.g.dart';

@JsonSerializable()
class Restaurante {
  int id;
  String nombre;
  String direccion;
  String telefono;
  int id_prestador;
  String facebook;
  String descripcion;
  String foto;

  Restaurante({
    this.id = -1,
    this.nombre = 'indefinido',
    this.direccion = 'indefinido',
    this.telefono = 'indefinido',
    this.id_prestador = -1,
    this.facebook = 'indefinido',
    this.descripcion = 'indefinido',
    this.foto = "",
  });

  // Método de fábrica que crea una instancia de Restaurante a partir de un mapa JSON.
  factory Restaurante.fromJson(Map<String, dynamic> json) =>
      _$RestauranteFromJson(json);

  // Método que convierte una instancia de Restaurante a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'id_prestador': id_prestador,
      'facebook': facebook,
      'descripcion': descripcion,
      'foto': foto,
    };
  }

  // Método toString para imprimir la representación de la clase.
  @override
  String toString() {
    return 'Restaurante{id: $id, nombre: $nombre, direccion: $direccion, telefono: $telefono, id_prestador: $id_prestador, facebook: $facebook, descripcion: $descripcion, foto: $foto}';
  }
}
