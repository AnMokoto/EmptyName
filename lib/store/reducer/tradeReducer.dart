import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';
@protected
final List<Reducer<AppState>> tradeReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, TradeResponseAction>((state, action) {
    state.tradeModel.list  = action.model;
    return state;
  }),

];
final List<Reducer<AppState>> rechargeReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, RechargeResponseAction>((state, action) {
//    state.tradeModel.list  = action.model;
    return state;
  }),

];
