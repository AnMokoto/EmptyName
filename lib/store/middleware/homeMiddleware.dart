import '../models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../net/net.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

@protected
final homeMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, IndexRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(IndexResponseAction(FixBoxModel.fromJsonToList(value)));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),new TypedMiddleware<AppState, BannerRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(BannerResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
  new TypedMiddleware<AppState, SecondRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(SecondResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  })
  ,new TypedMiddleware<AppState, OpencodeRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(OpencodeResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
