/////////////////////////////////////////////////
///   跟用户数据有关的 [Action] 放在这里管理     ///
////////////////////////////////////////////////

library app.store.action.log;

import '_action.dart';
import 'package:flutter/material.dart' show BuildContext;

/////////////////////////////////////
///
///  待登录流程完善后,更改[token]
///
////////////////////////////////////
class LoginRequestAction extends HttpStoreAction {
  LoginRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  // TODO: implement path
  String get path => "user/login";
}

class RegisterRequestAction extends HttpStoreAction {
  RegisterRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  // TODO: implement path
  String get path => "user/register";
}

/// 登录成功后发送
class LoginAction extends StoreAction {
  /// 临时数据
  /// 改成传递model
  final String token;

  LoginAction({this.token}) : assert(token != null);
}

/// 用户状态查询 无状态直接 [Null]
///
/// See alse:
/// * [LogMiddleware]
class LogStateAction extends StoreAction {
  BuildContext context;
  LogStateAction({this.context}) : assert(context != null);
}

/// 退出前发送
class LogOutAction extends StoreAction {
  LogOutAction();
}

/// 获取用户基本信息
class UserRequestAction extends HttpStoreAction {
  UserRequestAction();
  @override
  String get path => "user/userinfo";
}

class UserResponseAction extends StoreAction {
  dynamic value;
  UserResponseAction({this.value});
}

/// 获取用户余额信息
class UserRequestBalanceAction extends HttpStoreAction {
  UserRequestBalanceAction();
  @override
  String get path => "user/balance";
}

class UserResponseBalanceAction extends StoreAction {
  dynamic value;
  UserResponseBalanceAction({this.value});
}
