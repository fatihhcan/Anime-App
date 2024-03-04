import 'package:json_annotation/json_annotation.dart';
import '../../../core/base/model/base_model.dart';
import '../../anime_list/model/images_model.dart';
import 'character_model.dart';

part 'anime_detail_response_model.g.dart';

@JsonSerializable()
class AnimeDetailResponseModel extends BaseModel<AnimeDetailResponseModel>{
  CharacterModel? character;
  AnimeDetailResponseModel({this.character});

 factory AnimeDetailResponseModel.fromJson(Map<String, dynamic> json) => _$AnimeDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>  _$AnimeDetailResponseModelToJson(this);

  @override
  AnimeDetailResponseModel fromJson(Map<String, dynamic> json) {
    return _$AnimeDetailResponseModelFromJson(json);
  }
}