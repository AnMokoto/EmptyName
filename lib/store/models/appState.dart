library app.store.models.appstate;

import 'index.dart';
import '../net/index.dart';
import 'playModel.dart';
import 'homeModel.dart';
import 'OpencodeModel.dart';
import 'user.dart';
import 'TradeModel.dart';
import 'MessageModel.dart';
import 'KefyModel.dart';
const price = 2.0;
//const dynamic HOST_NAME = "http://178.128.21.119:9003/";
const dynamic HOST_NAME = "http://api.484084.com/";

const dynamic REQUEST_HEAD = {
  "Content-Type": "application/json",
  "Accept": "application/json",
  //"Authorization": "test_token",
};

class AppState {
  static double price = 2.0;
  UserModel userModel;

  MessageModel messageModel;
  KefuModel kefuModel;
  LotplayModel lotplayModel;
  TradeModel tradeModel;
  OpencodeModel opencodeModel;
  PlayModel betModel;
  LotteryState lottery;
  LotteryRecord record;
  HomeModel homeModel;
  HttpRetrofit httpRetrofit;
  PaywayModel paywayModel;
  WithdrawMoel withdrawMoel;

  AppState() {
    this.kefuModel = new KefuModel();
    this.lotplayModel = new LotplayModel();
    this.withdrawMoel = new WithdrawMoel();
    this.paywayModel = new PaywayModel();
    this.opencodeModel = new OpencodeModel();
    this.homeModel = HomeModel();
    this.lottery = new LotteryState();
    this.betModel = new PlayModel();
    this.record = new LotteryRecord();
    this.httpRetrofit = HttpRetrofit.from(HOST_NAME)..setHeaders(REQUEST_HEAD);
    this.tradeModel = new TradeModel();
    this.messageModel = new MessageModel();
    this.userModel = new UserModel();
  }

  String get token => userModel.token;
  set token(String token) {
    this.userModel.token = token;
    this
        .httpRetrofit
        .addHeaders(key: "Authorization", value: this.userModel.token);
  }

  factory AppState.from() {
    return new AppState();
  }
}

/// 数据层次
abstract class AppModel extends Object {}

AppState appState() => AppState.from();
