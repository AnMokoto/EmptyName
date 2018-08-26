import 'package:redux/redux.dart';
import '../actions/lotteryAction.dart';
import '../models/index.dart';
import 'package:flutter/foundation.dart';

/// reducer
//
@protected
final List<Reducer<AppState>> betReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, LotterBetQuery>((state, action) {
    state.betModel
      ..gameEn = action.gameEn ?? state.betModel.gameEn
      ..expectNo = action.expectNo ?? state.betModel.expectNo;
    return state;
  }),
  new TypedReducer<AppState, LotteryClearAction>((state, action) {
    print("LotteryClearAction");
    state.betModel = new PlayModel();
    return state;
  }),
  new TypedReducer<AppState, LotterBetAdd>((state, action) {
    state.betModel.content..add(action.item);

    return _initContentWithDetail(state);
  }),
  new TypedReducer<AppState, LotterBetDelete>((state, action) {
    var data = state.betModel.content;
    if (action.index > -1 && action.index < data.length) {
      data.removeAt(action.index);
      state.betModel.content = data;
    }
    return _initContentWithDetail(state);
  }),
];

AppState _initContentWithDetail(AppState state) {
  var money = 0.0;
  var count = 0;

  state.betModel.content.forEach((f) {
    money += f.money;
    count += f.zhushu;
  });
  state.betModel.money = money.toString();
  state.betModel.zhushu = count;

  return state;
}

@protected
final List<Reducer<AppState>> lotteryReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, LotteryInitQueryAction>((state, action) {
    state.lottery.lottery = action.lottery ?? state.lottery.lottery;
    state.lottery.history = action.history ?? state.lottery.history;
    return state;
  }),
];

@protected
final List<Reducer<AppState>> recordReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, LotteryRecordResponseAction>((state, action) {
    state.record.data = action.data;
    return state;
  }),
  new TypedReducer<AppState, LotteryRecordDetailResponseAction>(
      (state, action) {
    state.record.detail = action.data;
    return state;
  }),
];
