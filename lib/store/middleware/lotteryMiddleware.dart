import 'package:redux/redux.dart';
import '../actions/index.dart';
import '../models/index.dart';
import '../sp.dart';
import 'package:flutter/material.dart';
import '../actions/_HttpAction.dart';
import '../net/net.dart';
import 'package:flutter/cupertino.dart';
import 'package:lowlottery/layout/record/ProjectDetail.dart';
//临时弹窗
void requestWhenwhohasreallytoPaySuccess(BuildContext context, dynamic data) {
  var leftstyle = new TextStyle(fontSize: 14.0, color: Colors.grey);
  var style = new TextStyle(fontSize: 14.0, color: Colors.red);
  showDialog(
    context: context,
    builder: (context) => new CupertinoAlertDialog(
          title: new Text("投注成功"),
          content: new Text(""),
          actions: <Widget>[
            new CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new ProjectDetail(
                      projectEn: data["projectEn"] ?? "-",
                    )));
              },
              child: new Text(
                "查看方案",
                style: leftstyle,
              ),
            ),
            new CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text(
                "继续投注",
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
    transform(response, next,action.context).then((value) {
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
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        store.state.betModel.content = new List();
        requestWhenwhohasreallytoPaySuccess(action.context, value);
        next(action);
      }
    });
    next(HttpProgressAction(action.context, false));
  }),
];

@protected
final lotterMiddleware = <Middleware<AppState>>[
  new TypedMiddleware<AppState, LotteryExpectNowAction>(
      (store, action, NextDispatcher next) async {
    next(HttpProgressAction(action.context, true));
    var api = store.state.httpRetrofit;
    var response = await api.post(path: action.path, body: action.body);
    transform(response, next,action.context).then((value) {
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
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        final history = Lottery.fromJsonToList(value);
        next(LotteryInitRecordQueryAction(history: history));
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
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(LotteryRecordResponseAction(value['dataList']));
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
    transform(response, next,action.context).then((value) {
      print("${action.path}-------$value");
      if (!(value is Exception)) {
        next(LotteryRecordDetailResponseAction(value));
      }
    });
    next(HttpProgressAction(action.context, false));
    next(action);
  }),
];
