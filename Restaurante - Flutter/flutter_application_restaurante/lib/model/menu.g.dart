// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      id: (json['id'] as num?)?.toInt() ?? -1,
      nombre: json['nombre'] as String? ?? 'sin menu.',
      foto: json['foto'] as String? ?? '',
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'foto': instance.foto,
    };
