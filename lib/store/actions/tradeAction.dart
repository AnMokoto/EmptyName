import '_action.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

class TradeRequestAction extends HttpStoreAction {
  TradeRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "trade/record";
}

class TradeResponseAction extends StoreAction {
  List<dynamic> model;

  TradeResponseAction(this.model);
}
