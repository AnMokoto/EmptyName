import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';

@protected
final List<Reducer<AppState>> opencodeReducer = <Reducer<AppState>>[

  new TypedReducer<AppState, OpencodeResponseAction>((state, action) {
    state.opencodeModel.list = action.model;
    return state;
  }),
];


