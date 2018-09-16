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

//// banners
class BannerRequestAction extends HttpStoreAction {
  BannerRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "banners";
}

class BannerResponseAction extends StoreAction {
  List<dynamic> model;
  BannerResponseAction(this.model);
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

class ThirdResponseAction extends StoreAction {
  List<FixBoxModel> model;
  ThirdResponseAction(this.model);
}

class OpencodeRequestAction extends HttpStoreAction {
  OpencodeRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "opencodeList";
}

class OpencodeResponseAction extends StoreAction {
  List<dynamic> model;
  OpencodeResponseAction(this.model);
}

class LotplayRequestAction extends HttpStoreAction {
  LotplayRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "lotPlayConfig";
}

class LotplayResponseAction extends StoreAction {
  List<dynamic> model;
  LotplayResponseAction(this.model);
}
