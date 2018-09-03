import 'package:redux/redux.dart';
import '../models/index.dart';
import '../actions/_HttpAction.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

//// 拦截所有错误提示 未完成
@protected
final httpMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, HttpErrorAction>(
      (store, action, NextDispatcher next) {
    next(action);
    // demo
    if (isState(action.state)) {
      next(HttpMsgAction(msg: action.msg));
    }
  }),
  new TypedMiddleware<AppState, HttpMsgAction>(
      (store, action, NextDispatcher next) {
    next(action);
    Fluttertoast.showToast(
        msg: action.msg ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff');
  }),
];

bool isState(dynamic state) {
  // demo
  return state == 300;
}
