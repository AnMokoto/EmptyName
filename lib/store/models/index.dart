library app.store.models;

import 'package:lowlottery/layout/bet/LotteryBetState.dart';
import 'package:lowlottery/layout/lottery/LotterState.dart';
const price = 2.0;

class AppState {
  static double price = 2.0;

  LotteryBetModel betModel;
  LotteryState lottery;

  AppState(){
    this.lottery = new LotteryState();
    this.betModel = new LotteryBetModel();
  }

  factory AppState.from() {
    return new AppState();
  }

}

/// 数据层次
abstract class AppModel extends Object {}
