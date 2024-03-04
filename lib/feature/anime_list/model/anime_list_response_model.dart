import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/model/base_model.dart';
import '../../anime_detail/model/genres_model.dart';
import 'images_model.dart';

part 'anime_list_response_model.g.dart';

@JsonSerializable()
class AnimeListResponseModel extends BaseModel<AnimeListResponseModel>{
  int? malId;
  String? url;
  Images? images;
  String? title;
  String? type;
  String? source;
  int? episodes;
  double? score;
  String? synopsis;
  List<Genres>? genres;


  AnimeListResponseModel(
      {this.malId,
      this.url,
      this.images,
      this.title,
      this.type,
      this.source,
      this.episodes,
      this.score,
      this.synopsis,
      this.genres
      });


 factory AnimeListResponseModel.fromJson(Map<String, dynamic> json) => _$AnimeListResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>  _$AnimeListResponseModelToJson(this);

  @override
  AnimeListResponseModel fromJson(Map<String, dynamic> json) {
    return _$AnimeListResponseModelFromJson(json);
  }
}