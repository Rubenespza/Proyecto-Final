// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comida.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comida _$ComidaFromJson(Map<String, dynamic> json) => Comida(
      (json['id'] as num).toInt(),
      json['nombre'] as String,
      (json['id_menu'] as num).toInt(),
      json['precio'] as String,
      json['foto'] as String,
      json['descripcion'] as String,
    );

Map<String, dynamic> _$ComidaToJson(Comida instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'id_menu': instance.id_menu,
      'precio': instance.precio,
      'foto': instance.foto,
      'descripcion': instance.descripcion,
    };
