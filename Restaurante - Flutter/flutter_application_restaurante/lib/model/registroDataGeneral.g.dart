// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registroDataGeneral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroDataGeneral _$RegistroDataGeneralFromJson(Map<String, dynamic> json) =>
    RegistroDataGeneral(
      usuario: Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
      prestador: Prestador.fromJson(json['prestador'] as Map<String, dynamic>),
      restaurante:
          Restaurante.fromJson(json['restaurante'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegistroDataGeneralToJson(
        RegistroDataGeneral instance) =>
    <String, dynamic>{
      'usuario': instance.usuario,
      'prestador': instance.prestador,
      'restaurante': instance.restaurante,
    };
