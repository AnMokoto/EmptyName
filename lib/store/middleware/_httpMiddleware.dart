import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lowlottery/layout/login/LoginLayer.dart';
import 'package:lowlottery/store/AppStore.dart';
import 'package:redux/redux.dart';

import '../actions/_HttpAction.dart';
import '../models/index.dart';
//// 拦截所有错误提示 未完成
@protected
final httpMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, HttpErrorAction>(
      (store, action, NextDispatcher next) {
    next(action);
    // demo
    if (isState(action.state)) {
      next(HttpMsgAction(msg: action.msg));
    }else if (action.context!=null && nologin(action.state) ) {
      Navigator.of(action.context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new LoginLayer(),
      ));
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
  return state == 600;
}

bool nologin(dynamic state) {
  // demo
  return state == 300;
}
