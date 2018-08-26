import 'package:redux/redux.dart';
import '../models/index.dart';
import '../actions/_HttpAction.dart';
import 'package:flutter/foundation.dart';

//// 拦截所有错误提示 未完成
@protected
final httpMiddleware = new TypedMiddleware<AppState, HttpAction>(
    (store, action, NextDispatcher next) {
  next(action);
});
