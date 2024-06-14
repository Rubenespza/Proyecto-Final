import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  int id;
  String usuario;
  String password;

  Usuario({
    this.id = -1,
    this.usuario = 'sin usuario.',
    this.password = 'sin password.',
  });

  // Método de fábrica que crea una instancia de Usuario a partir de un mapa JSON.
  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  // Método que convierte una instancia de Usuario a un mapa JSON.
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  // Método toString para imprimir la representación de la clase.
  @override
  String toString() {
    return 'Usuario{id: $id, usuario: $usuario, password: $password}';
  }
}
