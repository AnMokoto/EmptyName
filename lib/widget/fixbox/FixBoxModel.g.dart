// GENERATED CODE - DO NOT MODIFY BY HAND

part of fixboxModel;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

FixBoxModel _$FixBoxModelFromJson(Map<String, dynamic> json) =>
    new FixBoxModel(id: json['id'], name: json['name'], url: json['url']);

abstract class _$FixBoxModelSerializerMixin {
  dynamic get id;
  dynamic get name;
  dynamic get url;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'url': url};
}
