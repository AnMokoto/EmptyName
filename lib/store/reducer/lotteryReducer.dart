import 'package:redux/redux.dart';
import '../actions/lotteryAction.dart';
import '../models/index.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

/// reducer
//
@protected
final List<Reducer<AppState>> betReducer = <Reducer<AppState>>[
  new TypedReducer<AppState, LotterBetQuery>((state, action) {
    /// 期号过期 重置
    ///  初始化拉去重置

    state.betModel
      ..gameEn = action.gameEn ?? state.betModel.gameEn
      ..expectNo = action.expectNo ?? state.betModel.expectNo;

    return state;
  }),
  new TypedReducer<AppState, LotteryClearAction>((state, action) {
    print("LotteryClearAction");
    state.betModel = new PlayModel();
    state.lottery = new LotteryState();
    return state;
  }),
  new TypedReducer<AppState, LotteryRandomAction>((state, action) {
    state.betModel.content..addAll(action.items);
    return _initContentWithDetail(state);
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
    state.lottery.lottery = action.lottery;
    return state;
  }),
  new TypedReducer<AppState, LotteryInitRecordQueryAction>((state, action) {
    state.lottery.history = action.history;
    return state;
  }),
  new TypedReducer<AppState, LotteryRefreshDeadLineAction>((state, action) {
    if (state.lottery.lottery != null) {
      var deadLine = state.lottery.lottery.remainTime as int;
      deadLine -= 1000;
      deadLine = max(0, deadLine);
      state.lottery.lottery.remainTime = deadLine;
    }
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
