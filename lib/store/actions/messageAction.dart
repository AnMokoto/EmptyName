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
