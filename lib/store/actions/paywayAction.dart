import '_action.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

class PaywayRequestAction extends HttpStoreAction {
  PaywayRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "payways";
}

class PaywayResponseAction extends StoreAction {
  List<dynamic> model;

  PaywayResponseAction(this.model);
}
class WithrawRequestAction extends HttpStoreAction {
  WithrawRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "trade/applyWithdraw";
}

class WithdrawResponseAction extends StoreAction {
  List<dynamic> model;

  WithdrawResponseAction(this.model);
}
class CardRequestAction extends HttpStoreAction {
  CardRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "addCard";
}

class CardResponseAction extends StoreAction {
  List<dynamic> model;

  CardResponseAction(this.model);
}
