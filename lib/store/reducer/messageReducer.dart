import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';
@protected
final List<Reducer<AppState>> messageReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, MessageResponseAction>((state, action) {
    state.messageModel.list  = action.model;
    return state;
  }),

];
