library fixboxModel;

import 'package:json_annotation/json_annotation.dart';

part 'FixBoxModel.g.dart';


//  {
//       "gameEn": "cqssc",
//       "totalExpect": 120,
//       "name": "重庆时时彩",
//       "desc": "全天120期",
//       "iconUnicode": "&#xe606;",
//       "sale": 1
//     }


@JsonSerializable()
class FixBoxModel extends Object with _$FixBoxModelSerializerMixin {
  var gameEn;
  var name;
  var iconUnicode;
  var desc;
  var totalExpect;


  FixBoxModel({this.gameEn, this.name, this.iconUnicode,this.desc,this.totalExpect});

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
