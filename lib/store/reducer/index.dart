library app.store.reducer;

import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';

import '../models/index.dart';
import 'userReducer.dart';
import 'lotteryReducer.dart';
import 'homeReducer.dart';
import 'OpencodeReducer.dart';
import 'tradeReducer.dart';
import 'messageReducer.dart';
import 'PaywayReducer.dart';

AppState appReducer(AppState state, dynamic action) {
  ///  model.reducer
  return _reducer(state, action);
  //return state;
}

//// 不动
@protected
final _reducer = combineReducers<AppState>(_list);

//// 增加了在这里 `..addAll()`
@protected
final List<Reducer<AppState>> _list = <Reducer<AppState>>[]
  ..addAll(rechargeReducer)
  ..addAll(tradeReducer)
  ..addAll(messageReducer)
  ..addAll(opencodeReducer)
  ..addAll(logReducer)
  ..addAll(userReducer)
  ..addAll(betReducer)
  ..addAll(lotteryReducer)
  ..addAll(recordReducer)
  ..addAll(paywayReducer)
  ..addAll(withdrawReducer)
  ..addAll(cardReducer)
  ..addAll(homeReducer);
