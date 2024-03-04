// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeListResponseModel _$AnimeListResponseModelFromJson(
        Map<String, dynamic> json) =>
    AnimeListResponseModel(
      malId: json['mal_id'] as int?,
      url: json['url'] as String?,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
      title: json['title'] as String?,
      type: json['type'] as String?,
      source: json['source'] as String?,
      episodes: json['episodes'] as int?,
      score: (json['score'] as num?)?.toDouble(),
      synopsis: json['synopsis'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..localId = json['localId'] as int?;

Map<String, dynamic> _$AnimeListResponseModelToJson(
        AnimeListResponseModel instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'mal_id': instance.malId,
      'url': instance.url,
      'images': instance.images,
      'title': instance.title,
      'type': instance.type,
      'source': instance.source,
      'episodes': instance.episodes,
      'score': instance.score,
      'synopsis': instance.synopsis,
      'genres': instance.genres,
    };
