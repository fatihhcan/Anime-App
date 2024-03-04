// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      jpg: json['jpg'] == null
          ? null
          : Jpg.fromJson(json['jpg'] as Map<String, dynamic>),
    )..localId = json['localId'] as int?;

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'localId': instance.localId,
      'jpg': instance.jpg,
    };
