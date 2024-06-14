// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurante.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurante _$RestauranteFromJson(Map<String, dynamic> json) => Restaurante(
      id: (json['id'] as num?)?.toInt() ?? -1,
      nombre: json['nombre'] as String? ?? 'indefinido',
      direccion: json['direccion'] as String? ?? 'indefinido',
      telefono: json['telefono'] as String? ?? 'indefinido',
      id_prestador: (json['id_prestador'] as num?)?.toInt() ?? -1,
      facebook: json['facebook'] as String? ?? 'indefinido',
      descripcion: json['descripcion'] as String? ?? 'indefinido',
      foto: json['foto'] as String? ?? "",
    );

Map<String, dynamic> _$RestauranteToJson(Restaurante instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'direccion': instance.direccion,
      'telefono': instance.telefono,
      'id_prestador': instance.id_prestador,
      'facebook': instance.facebook,
      'descripcion': instance.descripcion,
      'foto': instance.foto,
    };
