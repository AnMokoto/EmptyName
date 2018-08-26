import '_action.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

//// 首页第一屏 Action
class IndexRequestAction extends HttpStoreAction {
  IndexRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "lotConfig";
}

class IndexResponseAction extends StoreAction {
  List<FixBoxModel> model;
  IndexResponseAction(this.model);
}

////
///第二屏
class SecondRequestAction extends HttpStoreAction {
  SecondRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "allLotOpencodeList";
}

class SecondResponseAction extends StoreAction {
  List<dynamic> model;
  SecondResponseAction(this.model);
}
