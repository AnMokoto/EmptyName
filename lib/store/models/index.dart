library app.store.models;

import 'package:lowlottery/style/index.dart';
import 'package:lowlottery/layout/lottery/LotterState.dart';

const price = 2.0;

class AppState {
  static double price = 2.0;
  String token = "";

  PlayModel betModel;
  LotteryState lottery;

  AppState() {
    this.lottery = new LotteryState();
    this.betModel = new PlayModel();
  }

  factory AppState.from() {
    return new AppState();
  }
}

/// 数据层次
abstract class AppModel extends Object {}
