// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registroRequestComida.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroRequestComida _$RegistroRequestComidaFromJson(
        Map<String, dynamic> json) =>
    RegistroRequestComida(
      comida: Comida.fromJson(json['comida'] as Map<String, dynamic>),
      id_restaurante: (json['id_restaurante'] as num).toInt(),
      menu: json['menu'] as String,
      usuario: json['usuario'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegistroRequestComidaToJson(
        RegistroRequestComida instance) =>
    <String, dynamic>{
      'comida': instance.comida,
      'id_restaurante': instance.id_restaurante,
      'menu': instance.menu,
      'usuario': instance.usuario,
      'password': instance.password,
    };
