import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/model/base_model.dart';

part 'genres_model.g.dart';

@JsonSerializable()
class Genres extends BaseModel<Genres>{
  int? malId;
  String? type;
  String? name;
  String? url;

  Genres({this.malId, this.type, this.name, this.url});

 factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() =>  _$GenresToJson(this);

  @override
  Genres fromJson(Map<String, dynamic> json) {
    return _$GenresFromJson(json);
  }
}