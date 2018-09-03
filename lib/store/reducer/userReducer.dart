/////////////////////////////////////////////////
///   跟用户数据有关的 [Reducer] 放在这里管理     ///
////////////////////////////////////////////////

import 'package:redux/redux.dart';
import '../models/index.dart';
import '../actions/userAction.dart';
import 'package:flutter/foundation.dart';

/// 账户操作
@protected
final List<Reducer<AppState>> logReducer = <Reducer<AppState>>[
  TypedReducer<AppState, LoginAction>((state, action) {
    state.token = action.token;
    return state;
  }),
  TypedReducer<AppState, LogOutAction>((state, action) {
    state.token = "";
    return state;
  }),
];

/// 用户信息
@protected
final List<Reducer<AppState>> userReducer = <Reducer<AppState>>[
  TypedReducer<AppState, UserResponseAction>((state, action) {
    dynamic value = action.value;
    state.userModel.mUserInfo
      ..avatar = value['avatar'] ?? null
      ..nickName = value['nickName'] ?? ""
      ..phone = value['phone'] ?? ""
      ..username = value['username'] ?? ""
      ..phone = value['phone'] ?? "";
    return state;
  }),
  TypedReducer<AppState, UserResponseBalanceAction>((state, action) {
    dynamic value = action.value;
    state.userModel.mUserBalance =
        new UserBalance(value['totalBalance'] ?? 0, value['withdrawable'] ?? 0);
    return state;
  }),
];
