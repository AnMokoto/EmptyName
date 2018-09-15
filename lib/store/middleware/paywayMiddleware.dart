import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import '../net/net.dart';
@protected
final paywayMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, PaywayRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
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
  new TypedMiddleware<AppState, WithrawRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(WithdrawResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
final cardMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, CardRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(CardResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
