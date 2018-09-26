import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import '../net/net.dart';
@protected
final messageMiddleware = <Middleware<AppState>>[
  //用户消息
  new TypedMiddleware<AppState, MessageRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(MessageResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
  //客服列表
  new TypedMiddleware<AppState, KefuRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(KefuResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
