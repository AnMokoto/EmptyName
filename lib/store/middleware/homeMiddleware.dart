import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:redux/redux.dart';

import '../actions/_HttpAction.dart';
import '../actions/index.dart';
import '../models/index.dart';
import '../net/net.dart';
import '../sp.dart';

@protected
final homeMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, IndexRequestAction>(
      (store, action, NextDispatcher next) async {
        var type = '${action.body['type']}';
        var key = 'lotConf$type' ;
        print('cache key $key');
        var cache = await SPHelper.valueDate(key: key, def: null).then((token) {
          if (token == null) {
            return "0";
          } else {
            print('lotconf data from cache') ;
            if(type == 'all')
            next(ThirdResponseAction(FixBoxModel.fromJsonToList(json.decode(token))));
            else
              next(IndexResponseAction(FixBoxModel.fromJsonToList(json.decode(token))));
          }
          return "1";
        });
        if(cache == '0') {
          next(HttpProgressAction(action.context, true));
          var api = store.state.httpRetrofit;
          var response = await api.post(path: action.path, body: action.body);
          transform(response, next, action.context).then((value) {
            print("${action.path}-------$value");
            if (!(value is Exception)) {
              var model = FixBoxModel.fromJsonToList(value);
              SPHelper.saveDate(key: key , value: json.encode(value)) ;
              if (action.body['type'] == "all") {
                next(ThirdResponseAction(model));
              } else {
                next(IndexResponseAction(model));
              }
            }
          });
          next(HttpProgressAction(action.context, false));
        }
    next(action);
  }),
  new TypedMiddleware<AppState, BannerRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
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
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(SecondResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
  new TypedMiddleware<AppState, OpencodeRequestAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(OpencodeResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];

final lotplayMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, LotplayRequestAction>(
          (store, action, NextDispatcher next) async {
        next(HttpProgressAction(action.context, true));

        var key = 'lotPlayConf' ;
        var cache = await SPHelper.valueDate(key: key, def: null).then((token) {
          if (token == null) {
            return "0";
          } else {
            print('lotplayconf data from cache') ;
            next(LotplayResponseAction(json.decode(token)));
          }
          return "1";
        });
        if(cache == '0') {
          var api = store.state.httpRetrofit;
          var response = await api.post(path: action.path, body: action.body);
          transform(response, next, action.context).then((value) {
            print("${action.path}-------$value");
            if (!(value is Exception)) {
              SPHelper.saveDate(key:key, value: json.encode(value));
              next(LotplayResponseAction(value));
            }
          });
          next(HttpProgressAction(action.context, false));
        }
        next(action);
      }),
];
