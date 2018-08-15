import 'package:lowlottery/store/AppStore.dart'
    show AppState, AppModel, StoreAction;
import 'LotteryModel.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    this.history = new List();
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
    state.history =  new List();
    return state;
  }),
]);

final lotterMiddleware = [
  new TypedMiddleware<LotteryState, LotteryQueryAction>(
      (store, action, NextDispatcher next) {
    next(action);
  }),
];
