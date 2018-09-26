import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import '../net/net.dart';
import 'package:lowlottery/layout/pops/CommonPop.dart';
@protected
final paywayMiddleware = <Middleware<AppState>>[
  //支付方式列表
  new TypedMiddleware<AppState, PaywayRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(PaywayResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
final withdrawlMiddleware = <Middleware<AppState>>[
  //提现申请
  new TypedMiddleware<AppState, WithrawRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        CommonPop.pop(action.context, '提现申请', '${value}') ;
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
final cardMiddleware = <Middleware<AppState>>[
  //添加银行卡，支付宝
  new TypedMiddleware<AppState, CardRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(CardResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];

final modifyPwdMiddleware = <Middleware<AppState>>[
  //修改用户信息
  new TypedMiddleware<AppState, ModifyPwdRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(ModifyPwdResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
