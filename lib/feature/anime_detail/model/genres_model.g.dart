// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genres _$GenresFromJson(Map<String, dynamic> json) => Genres(
      malId: json['malId'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    )..localId = json['localId'] as int?;

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'localId': instance.localId,
      'malId': instance.malId,
      'type': instance.type,
      'name': instance.name,
      'url': instance.url,
    };
