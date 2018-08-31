import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';

@protected
final List<Reducer<AppState>> homeReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, IndexResponseAction>((state, action) {
    state.homeModel.model = action.model;
    return state;
  }),
  new TypedReducer<AppState, SecondResponseAction>((state, action) {
    state.homeModel.second = action.model;
    return state;
  }),
  new TypedReducer<AppState, IndexResponseAction>((state, action) {
    state.homeModel.banners = action.model;
    return state;
  }),

];
