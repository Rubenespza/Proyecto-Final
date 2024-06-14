// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registroRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroRequest _$RegistroRequestFromJson(Map<String, dynamic> json) =>
    RegistroRequest(
      usuario: Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
      prestador: Prestador.fromJson(json['prestador'] as Map<String, dynamic>),
      restaurante:
          Restaurante.fromJson(json['restaurante'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegistroRequestToJson(RegistroRequest instance) =>
    <String, dynamic>{
      'usuario': instance.usuario,
      'prestador': instance.prestador,
      'restaurante': instance.restaurante,
    };
