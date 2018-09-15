import '../models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../net/net.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:lowlottery/store/actions/tradeAction.dart';
@protected
final tradeMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, TradeRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(TradeResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
final rechargeMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, RechargeRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(RechargeResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
