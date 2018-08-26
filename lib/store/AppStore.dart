library app.redux;

import 'models/index.dart';
import 'middleware/index.dart';
import 'package:redux/redux.dart';
import 'reducer/index.dart';
import 'package:flutter/material.dart' show BuildContext;

import 'package:flutter_redux/flutter_redux.dart';
export 'package:flutter_redux/flutter_redux.dart';
export 'package:redux/redux.dart';
export 'actions/index.dart';
export 'models/index.dart';
export 'sp.dart';
export 'net/index.dart';

Store<AppState> appStore = new Store<AppState>(
  appReducer,
  initialState: appState(),
  middleware: appMiddleware(),
  //middleware: [],
);

void dispatch(BuildContext context, dynamic action) {
  StoreProvider.of<AppState>(context).dispatch(action);
}
