import '_action.dart';
import '../models/index.dart';
import 'package:flutter/material.dart' show BuildContext;

///// action
/// lotttery bet
class LotterBetDelete extends StoreAction {
  int index;

  LotterBetDelete({int index: -1}) {
    this.index = index;
  }
}

class LotterBetAdd extends StoreAction {
  final PlayModelItem item;
  LotterBetAdd({this.item});
}

class LotterBetQuery extends StoreAction {
  String gameEn;
  String expectNo;
  LotterBetQuery({this.gameEn, this.expectNo});
}

class LotterBetRequestAction extends HttpStoreAction {
  LotterBetRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);
  @override
  String get path => "projectAdd";
}

class LotterBetPayRequestAction extends HttpStoreAction {
  LotterBetPayRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);
  @override
  String get path => "projectPay";
}

////// lottery
///

class LotteryQueryAction extends StoreAction {}

class LotteryClearAction extends StoreAction {}

class LotteryRefreshDeadLineAction extends StoreAction {}

/// 当前期数控制
class LotteryInitQueryAction extends StoreAction {
  final LotteryModel lottery;
  LotteryInitQueryAction({this.lottery});
}

/// 当前游戏玩法的历史开奖记录
class LotteryInitRecordQueryAction extends StoreAction {
  /// 历史记录
  List<Lottery> history;
  LotteryInitRecordQueryAction({this.history});
}

class LotteryExpectNowAction extends HttpStoreAction {
  LotteryExpectNowAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "expectNow";
}

class LotteryExpectRecordAction extends HttpStoreAction {
  LotteryExpectRecordAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "opencodeList";
}

///// records
class LotteryRecordAction extends HttpStoreAction {
  LotteryRecordAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "userProjectList";
}

class LotteryRecordResponseAction extends StoreAction {
  List<dynamic> data;
  LotteryRecordResponseAction(this.data);
}

class LotteryRecordDetailAction extends HttpStoreAction {
  LotteryRecordDetailAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "projectDetail";
}

class LotteryRecordDetailResponseAction extends StoreAction {
  Map<String, dynamic> data;
  LotteryRecordDetailResponseAction(this.data);
}
