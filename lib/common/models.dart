library imodel;

import 'package:json_annotation/json_annotation.dart';

class IModel<T> extends Object {
  IModel({this.code, this.success, this.data}) : assert(code != null);

  IModel.fromJson(Map<String, dynamic> json) {
    this.code ??= json['code'];
    this.success ??= json['success'];
    this.data ??= json['data'];
  }

  @JsonSerializable()
  String code;
  bool success;
  T data;
}
