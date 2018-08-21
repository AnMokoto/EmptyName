import 'package:lowlottery/store/AppStore.dart' show AppState, StoreAction;
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

/////////////////////////////////////
///
///  待登录流程完善后,更改[token]
///
////////////////////////////////////



/// 登录成功后发送
class LoginAction extends StoreAction {
  /// 临时数据
  /// 改成传递model
  final String token;

  LoginAction({this.token}) : assert(token != null);

  @override
  AppState reducer(AppState t) {
    return LoginReducer(t, this);
  }
}
/// 用户状态查询 无状态直接 [Null]
/// 
/// See alse:
/// * [LogMiddleware]
class LogStateAction extends StoreAction {
  LogStateAction();

  @override
  AppState reducer(AppState t) {
    /// ignore anthing
    /// see [#LogMiddleware][2]
    return t;
  }
}

/// 退出前发送
class LogOutAction extends StoreAction {
  LogOutAction();

  @override
  AppState reducer(AppState t) {
    return LoginReducer(t, this);
  }
}

/// 登录事件数据处理
final LoginReducer = combineReducers<AppState>([
  new TypedReducer<AppState, LoginAction>((state, model) {
    state.token ??= model.token;
    return state;
  }),
  new TypedReducer<AppState, LogOutAction>((state, model) {
    state.token = "";
    return state;
  }),
]);

/// 登录事件本地处理拦截
final LogMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, LoginAction>(
      (store, action, NextDispatcher next) {
        /// 这里保存本地session
    next(action);
  }),

   new TypedMiddleware<AppState, LogOutAction>(
      (store, action, NextDispatcher next) {
        /// 这里清除本地session
    next(action);
  }),

  
   new TypedMiddleware<AppState, LogStateAction>(
      (store, action, NextDispatcher next) {
        /// 这里查询本地session
    next(action);
  }),
];
