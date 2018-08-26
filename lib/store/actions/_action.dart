import 'package:flutter/material.dart' show BuildContext;

/// 原始 [action] 模型
/// action 就是 用来处理数据相关的逻辑
/// 等同于 `m v p` 中的 `p`
/// 事件操作具体的[AppModel]
abstract class StoreAction {}

abstract class HttpStoreAction {
  final Map<String, dynamic> body;
  BuildContext context;
  HttpStoreAction({this.context, this.body});

  String get path;
}
