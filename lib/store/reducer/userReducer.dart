/////////////////////////////////////////////////
///   跟用户数据有关的 [Reducer] 放在这里管理     ///
////////////////////////////////////////////////

import 'package:redux/redux.dart';
import '../models/index.dart';
import '../actions/userAction.dart';
import 'package:flutter/foundation.dart';

@protected
final List<Reducer<AppState>> logReducer = <Reducer<AppState>>[
  TypedReducer<AppState, LoginAction>((state, action) {
    state.token ??= action.token;
    return state;
  }),
  TypedReducer<AppState, LogOutAction>((state, action) {
    state.token = "";
    return state;
  }),
];
