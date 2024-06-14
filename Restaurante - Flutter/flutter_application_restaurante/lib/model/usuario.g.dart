// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      id: (json['id'] as num?)?.toInt() ?? -1,
      usuario: json['usuario'] as String? ?? 'sin usuario.',
      password: json['password'] as String? ?? 'sin password.',
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario,
      'password': instance.password,
    };
