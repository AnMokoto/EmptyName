// GENERATED CODE - DO NOT MODIFY BY HAND

part of fixboxModel;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

FixBoxModel _$FixBoxModelFromJson(Map<String, dynamic> json) =>

    ///this.gameEn, this.name, this.iconUnicode,this.desc,this.totalExpect
    new FixBoxModel(
        gameEn: json['gameEn'],
        name: json['name'],
        iconUnicode: json['iconUnicode'],
        desc: json['desc'],
        totalExpect: json['totalExpect']);

abstract class _$FixBoxModelSerializerMixin {
  dynamic get gameEn;
  dynamic get name;
  dynamic get iconUnicode;
  dynamic get desc;
  dynamic get totalExpect;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'gameEn': gameEn,
        'name': name,
        'iconUnicode': iconUnicode,
        'desc': desc,
        'totalExpect': totalExpect
      };
}
