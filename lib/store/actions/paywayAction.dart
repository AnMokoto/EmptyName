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
