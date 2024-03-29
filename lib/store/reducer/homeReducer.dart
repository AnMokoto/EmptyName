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
    state.homeModel.opencodes = action.model;
    return state;
  }),
  new TypedReducer<AppState, ThirdResponseAction>((state, action) {
    state.homeModel.third = action.model;
    return state;
  }),
  new TypedReducer<AppState, BannerResponseAction>((state, action) {
    state.homeModel.banners = action.model;
    return state;
  }), new TypedReducer<AppState, SxResponseAction>((state, action) {
    state.homeModel.sxConfig = action.model;
    return state;
  }),
];


final List<Reducer<AppState>> lotplayReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, LotplayResponseAction>((state, action) {
    state.lotplayModel.list  = action.model;
    return state;
  }),

];
