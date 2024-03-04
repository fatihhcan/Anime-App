// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeDetailResponseModel _$AnimeDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    AnimeDetailResponseModel(
      character: json['character'] == null
          ? null
          : CharacterModel.fromJson(json['character'] as Map<String, dynamic>),
    )..localId = json['localId'] as int?;

Map<String, dynamic> _$AnimeDetailResponseModelToJson(
        AnimeDetailResponseModel instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'character': instance.character,
    };
