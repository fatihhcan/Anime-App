import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/model/base_model.dart';
import 'jpg_model.dart';
part 'images_model.g.dart';

@JsonSerializable()
class Images extends BaseModel<Images>{
  Jpg? jpg;

  Images({this.jpg});

 factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() =>  _$ImagesToJson(this);

  @override
  Images fromJson(Map<String, dynamic> json) {
    return _$ImagesFromJson(json);
  }
}