// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prestador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prestador _$PrestadorFromJson(Map<String, dynamic> json) => Prestador(
      id: (json['id'] as num?)?.toInt() ?? -1,
      nombre: json['nombre'] as String? ?? 'indefinido',
      apellido: json['apellido'] as String? ?? 'indefinido',
      direccion: json['direccion'] as String? ?? 'indefinido',
      id_usuario: (json['id_usuario'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$PrestadorToJson(Prestador instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'direccion': instance.direccion,
      'id_usuario': instance.id_usuario,
    };
