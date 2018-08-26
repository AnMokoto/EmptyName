import 'package:http/http.dart' show Response;
import '_action.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart' show BuildContext;

class HttpAction extends StoreAction {
  final NextDispatcher next;
  final Response response;
  final StoreAction action;
  HttpAction({this.response, this.action, this.next});
}

//// http 请求
// class HttpRequestAction extends StoreAction {
//   final String path;
//   final Map<String, dynamic> body;
//   HttpRequestAction({this.path, this.body});
// }

class HttpProgressAction extends StoreAction {
  final bool isShow;
  BuildContext context;
  HttpProgressAction(this.context, this.isShow);
}

class HttpErrorAction extends StoreAction {
  final String msg;
  HttpErrorAction({this.msg});
}
