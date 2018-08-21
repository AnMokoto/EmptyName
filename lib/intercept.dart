library app.intercept;

import 'package:redux/redux.dart' show Middleware;
import 'package:lowlottery/layout/lottery/LotterState.dart'
    show lotterMiddleware;
import 'package:lowlottery/layout/login/LoginState.dart' show LogMiddleware;
import 'package:lowlottery/store/AppStore.dart' show AppState;

/// 用户自定义拦截器
/// 调用在 [main.dart] 调用
final UserMiddleware = <Middleware<AppState>>[]
  ..addAll(lotterMiddleware)
  ..addAll(LogMiddleware);
