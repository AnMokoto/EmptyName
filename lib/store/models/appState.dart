library app.store.models.appstate;

import 'index.dart';
import '../net/index.dart';
import 'playModel.dart';
import 'homeModel.dart';

const price = 2.0;
const dynamic HOST_NAME = "http://178.128.21.119:10003/";

const dynamic REQUEST_HEAD = {
  "Content-Type": "application/json",
  "Accept": "application/json",
  //"Authorization": "test_token",
};

class AppState {
  static double price = 2.0;
  String _token = "";

  PlayModel betModel;
  LotteryState lottery;
  LotteryRecord record;
  HomeModel homeModel;
  HttpRetrofit httpRetrofit;

  AppState() {
    this.homeModel = HomeModel();
    this.lottery = new LotteryState();
    this.betModel = new PlayModel();
    this.record = new LotteryRecord();
    this.httpRetrofit = HttpRetrofit.from(HOST_NAME)..setHeaders(REQUEST_HEAD);
  }

  String get token => _token;
  set token(String token) {
    this._token = token;
    this.httpRetrofit.addHeaders(key: "Authorization", value: this._token);
  }

  factory AppState.from() {
    return new AppState();
  }
}

/// 数据层次
abstract class AppModel extends Object {}

AppState appState() => AppState.from();