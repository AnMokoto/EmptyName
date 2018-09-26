import '_action.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

class MessageRequestAction extends HttpStoreAction {
  MessageRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "messageList";
}

class MessageResponseAction extends StoreAction {
  List<dynamic> model;

  MessageResponseAction(this.model);
}

class KefuRequestAction extends HttpStoreAction {
  KefuRequestAction(BuildContext context, Map<String, dynamic> body)
      : super(context: context, body: body);

  @override
  String get path => "kefus";
}

class KefuResponseAction extends StoreAction {
  List<dynamic> model;

  KefuResponseAction(this.model);
}
