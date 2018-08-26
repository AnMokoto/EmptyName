import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';
import '../sp.dart';
import 'package:flutter/material.dart';
import '../actions/_HttpAction.dart';
import '../net/net.dart';
import 'package:flutter/cupertino.dart';

//临时弹窗
void requestWhenwhohasreallytoPaySuccess(BuildContext context, dynamic data) {
  var style = new TextStyle(fontSize: 10.0, color: Colors.lightBlue);
  showDialog(
    context: context,
    builder: (context) => new CupertinoAlertDialog(
          title: new Text("title"),
          content: new Text("success"),
          actions: <Widget>[
            new CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                //this.dispose();
                Navigator.of(context).pop();
              },
              child: new Text(
                "left",
                style: style,
              ),
            ),
            new CupertinoDialogAction(
              onPressed: () {
                //this.dispose();
                Navigator.of(context).pop();
              },
              child: new Text(
                "right",
                style: style,
              ),
            ),
          ],
        ),
  );
}

@protected
final betMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, LotterBetRequestAction>(
      (store, action, next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(LotterBetPayRequestAction(
            action.context, {"projectEn": value['projectEn']}));
      } else {
        next(HttpProgressAction(action.context, false));
      }
    });
    //next(HttpProgressAction(action.context, false));
    next(action);
  }),
  new TypedMiddleware<AppState, LotterBetPayRequestAction>(
      (store, action, next) async {
    //next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        requestWhenwhohasreallytoPaySuccess(action.context, value);
        next(action);
      }
    });
    next(HttpProgressAction(action.context, false));
  }),
];

@protected
final lotterMiddleware = <Middleware<AppState>>[
  // new TypedMiddleware<AppState, LotteryInitQueryAction>(
  //     (store, action, NextDispatcher next) async {
  //   next(action);
  // }),
  new TypedMiddleware<AppState, LotteryExpectNowAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        print("aaaaaa-------dvevew");
        var model = LotteryModel.fromJson(value);
        next(LotteryInitQueryAction(lottery: model));
        print("action.lottery----------------");

        next(
            new LotterBetQuery(gameEn: model.gameEn, expectNo: model.expectNo));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
  new TypedMiddleware<AppState, LotteryExpectRecordAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(LotteryInitQueryAction(history: Lottery.fromJsonToList(value)));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];

//// record
@protected
final recordMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, LotteryRecordAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(LotteryRecordResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
  new TypedMiddleware<AppState, LotteryRecordDetailAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(LotteryRecordDetailResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
