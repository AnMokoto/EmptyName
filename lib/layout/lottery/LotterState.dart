import 'package:lowlottery/store/AppStore.dart'
    show AppState, AppModel, StoreAction;
import 'LotteryModel.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import '../bet/LotteryBetState.dart' show LotterBetQuery;

class LotteryState {
  /// 当前记录信息 remainTime
  LotteryModel lottery;

  /// 历史记录
  List<Lottery> history = new List();
}

class LotteryQueryAction extends StoreAction {
  @override
  AppState reducer(AppState t) {
    return t;
  }
}

class LotteryInitQueryAction extends StoreAction {
  final LotteryModel lottery;

  /// 历史记录
  List<Lottery> history;
  LotteryInitQueryAction({this.lottery, List<Lottery> history}) {
    this.history = history ?? new List();
  }

  @override
  AppState reducer(AppState t) {
    t.lottery = lotteryReducer(t.lottery, this);
    return t;
  }
}

final lotteryReducer = combineReducers<LotteryState>([
  new TypedReducer<LotteryState, LotteryInitQueryAction>((state, action) {
    state.lottery = action.lottery ?? state.lottery;
    state.history = action.history ?? state.history;
    return state;
  }),
]);

final List<Middleware<AppState>> lotterMiddleware = [
  new TypedMiddleware<AppState, LotteryInitQueryAction>(
      (store, action, NextDispatcher next) async {
    if (action.lottery != null) {
      print("action.lottery----------------");
      print(action.lottery);
      await store.dispatch(new LotterBetQuery(
          gameEn: action.lottery.gameEn, expectNo: action.lottery.expectNo));
    }
    next(action);
  }),
];
