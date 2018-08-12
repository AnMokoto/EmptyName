library fixboxModel;

import 'package:json_annotation/json_annotation.dart';

part 'FixBoxModel.g.dart';

@JsonSerializable()
class FixBoxModel extends Object with _$FixBoxModelSerializerMixin {
  var id;
  var name;
  var url;

  FixBoxModel({this.id, this.name, this.url});

  factory FixBoxModel.fromJson(Map<String, dynamic> json) =>
      _$FixBoxModelFromJson(json);

  /// always not be null
  static List<FixBoxModel> fromJsonToList(List<dynamic> json) {
    List<FixBoxModel> list = new List();
    json.forEach((f) {
      try {
        list.add(FixBoxModel.fromJson(f));
      } catch (e) {}
    });
    return list;
  }
}
