import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';
@protected
final List<Reducer<AppState>> paywayReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, PaywayResponseAction>((state, action) {
    state.paywayModel.list  = action.model;
    return state;
  }),

];
final List<Reducer<AppState>> withdrawReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, WithdrawResponseAction>((state, action) {
//    state.withdrawMoel.list  = action.model;
    return state;
  }),

];

final List<Reducer<AppState>> cardReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, CardResponseAction>((state, action) {
//    state.withdrawMoel.list  = action.model;
    return state;
  }),

];

final List<Reducer<AppState>> modifyPwdReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, ModifyPwdResponseAction>((state, action) {
//    state.withdrawMoel.list  = action.model;
    return state;
  }),

];
