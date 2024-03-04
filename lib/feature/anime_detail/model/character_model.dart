import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/model/base_model.dart';
import '../../anime_list/model/images_model.dart';
part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel extends BaseModel<CharacterModel>{
  int? malId;
  String? url;
  Images? images;
  String? name;

  CharacterModel({this.malId, this.url, this.images, this.name});

 factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() =>  _$CharacterModelToJson(this);

  @override
  CharacterModel fromJson(Map<String, dynamic> json) {
    return _$CharacterModelFromJson(json);
  }
}