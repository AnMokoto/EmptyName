library net;

import 'package:http/http.dart' show Response;
import 'package:redux/redux.dart' show NextDispatcher;
import 'dart:convert';
import 'dart:async';
import '../actions/_HttpAction.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<dynamic> transform(Response response, NextDispatcher next ,BuildContext context) async {
  var errorMessage = response.statusCode.toString();
  dynamic code = errorMessage;
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    var success = body['success'] as bool && body['code'] == 200;
    if (success) {
      return body['data'];
    }
    errorMessage = body['message'];
    code = body['code'];
  }
  next(HttpErrorAction(state: code, msg: errorMessage ,context: context));
  return new Exception(errorMessage);
}

///
///
