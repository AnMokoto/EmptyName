library app.store.intercept;

import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';
import '../sp.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/layout/login/LoginLayer.dart';
import 'package:lowlottery/layout/home/HomeLayer.dart';
import 'package:flutter/foundation.dart';
import '../actions/_HttpAction.dart';
import '../net/net.dart';

/// 登录事件本地处理拦截
@protected
final userMiddleware = <Middleware<AppState>>[
  //// 登录逻辑
  new TypedMiddleware<AppState, LoginRequestAction>(
      (store, action, NextDispatcher next) async {
    next(new HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) async {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        /// 这里保存本地session
        var token = value['token'];
        next(LoginAction(token: token));
        SPHelper.save(key: "token", value: token).then((b) {
          Navigator.of(action.context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new HomeLayer(),
          ));
        });
      }
    });
    next(new HttpProgressAction(action.context, false));
    next(action);
  }),

  /// 注册逻辑
  new TypedMiddleware<AppState, RegisterRequestAction>(
      (store, action, NextDispatcher next) async {
    next(new HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) async {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        ///注册成功
        ///
        /// 这里保存本地session
        var token = value['token'];
        next(LoginAction(token: token));
        SPHelper.save(key: "token", value: token).then((b) {
          Navigator.of(action.context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new HomeLayer(),
          ));
        });
      }
    });
    next(new HttpProgressAction(action.context, false));
    next(action);
  }),

  new TypedMiddleware<AppState, LogOutAction>(
      (store, action, NextDispatcher next) {
    /// 这里清除本地session
    SPHelper.clear(key: "token").then((b) {
      next(action);
    });
    next(action);
  }),
  new TypedMiddleware<AppState, LogStateAction>(
      (store, action, NextDispatcher next) {
    /// 这里查询本地session

    SPHelper.value(key: "token", def: null).then((token) {
      store.state.token = token;
      if (token == null) {
        Navigator.of(action.context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new LoginLayer(),
        ));
      } else {
        Navigator.of(action.context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new HomeLayer(),
        ));
      }
      next(action);
    });
    next(action);
  }),
];

/// 获取用户数据
@protected
final userXMiddleware = <Middleware<AppState>>[
  //获取用户信息
  new TypedMiddleware<AppState, UserRequestAction>(
      (store, action, NextDispatcher next) async {
    //next(new HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(UserResponseAction(value: value));
      }
    });
    next(action);
  }),
  //用户额度查询
  new TypedMiddleware<AppState, UserRequestBalanceAction>(
      (store, action, NextDispatcher next) async {
        next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value ${store.state.toString()}");
      if (!(value is Exception)) {
        next(UserResponseBalanceAction(value: value));
      }
    });
    next(action);
        next(HttpProgressAction(action.context, true));
  }),
];
