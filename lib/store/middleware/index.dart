library app.store.middleware;

import 'package:redux/redux.dart';
import 'package:logging/logging.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter/foundation.dart';
import '../models/index.dart';
import '_httpMiddleware.dart';
import 'userMiddleware.dart';
import 'lotteryMiddleware.dart';
import 'homeMiddleware.dart';
import 'tradeMiddleware.dart';
import 'messageMiddleware.dart';
import 'paywayMiddleware.dart';
part 'middleware.dart';

/// 不动
@protected
List<Middleware<AppState>> appMiddleware() => _appMiddleware;

//// 增加了在这里 `..addAll()`
//// 测试发现 拦截器 分先后顺序 An'Mokoto
@protected
final List<Middleware<AppState>> _appMiddleware = <Middleware<AppState>>[
  AppMiddleware.from()
]
  ..addAll(paywayMiddleware)
  ..addAll(userMiddleware)
  ..addAll(userXMiddleware)
  ..addAll(lotterMiddleware)
  ..addAll(betMiddleware)
  ..addAll(recordMiddleware)
  ..addAll(tradeMiddleware)
  ..addAll(messageMiddleware)
  ..addAll(homeMiddleware)
  ..addAll(httpMiddleware);
