import 'package:json_annotation/json_annotation.dart';

part 'jpg_model.g.dart';

@JsonSerializable()
class Jpg {
  String? imageUrl;
  String? smallImageUrl;
  String? largeImageUrl;

  Jpg({this.imageUrl, this.smallImageUrl, this.largeImageUrl});

 factory Jpg.fromJson(Map<String, dynamic> json) => _$JpgFromJson(json);

  Map<String, dynamic> toJson() =>  _$JpgToJson(this);

  @override
  Jpg fromJson(Map<String, dynamic> json) {
    return _$JpgFromJson(json);
  }
}