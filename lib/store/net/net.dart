library net;

import 'package:http/http.dart' show Response;
import 'package:redux/redux.dart' show NextDispatcher;
import 'dart:convert';
import 'dart:async';
import '../actions/_HttpAction.dart';

Future<dynamic> transform(Response response, NextDispatcher next) async {
  var errorMessage = response.statusCode.toString();
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    var success = body['success'] as bool && body['code'] == 200;
    if (success) {
      return body['data'];
    }
    errorMessage = body['message'];
  }
  next(HttpErrorAction(msg: errorMessage));
  return new Exception(errorMessage);
}

///
///
