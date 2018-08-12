library httpfactory;

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:lowlottery/common/models.dart';

const dynamic HOST_NAME = "http://178.128.21.119:10003/";
var _client = new http.Client();

typedef void onComplete();

typedef void onError(Exception e);

typedef void onNext<T>(T t);

class IOnAction<T> {
  void onNext(T t) {}

  void onError(Exception e) {}

  void onComplete() {}
}

class OnAction<T> extends IOnAction<T> {
  onNext next;
  onError error;

  onComplete c;

  OnAction.onNext(onNext next) {
    OnAction.onError(next, (e) {});
  }

  OnAction.onError(onNext next, onError error) {
    OnAction.onComplete(next, error, () {});
  }

  OnAction.onComplete(onNext next, onError error, onComplete complete) {
    this.next = next;
    this.error = error;
    this.c = complete;
  }

  void OnNext(T t) {
    this.next(t);
  }

  void OnError(Exception e) {
    this.error(e);
  }

  void OnComplete() {
    this.c();
  }
}

void _abRequest(String path, Map<String, dynamic> map, IOnAction action) {
  var request = new http.Request("POST", Uri.parse(HOST_NAME + path));
  request.body = json.encode(map);
  request.headers['Content-Type'] = "application/json";
  request.headers['Accept'] = "application/json";
  _client
      .send(request)
      //.post(HOST_NAME+path, body: map)
      .timeout(Duration(milliseconds: 1000), onTimeout: () {})
      .then((response) {
    var state = response.statusCode;
    if (state == 200) {
      return response.stream.transform(utf8.decoder).join();
    }
    throw new FormatException("NetWork Error", null, state);
  }).then((response) {
    var body = json.decode(response);
    var success = body['success'] as bool;
    if (success) {
      action.onNext(body['body']);
    } else {
      action.onError(new FormatException(body['message'], null, -1));
    }
  }).whenComplete(() {
    _client.close();
    action.onComplete();
  }).catchError((error) {
    action.onError(error);
    action.onComplete();
  });
}

class HttpRetrofit {
  static void request(
      String path, Map<String, dynamic> map, onNext<dynamic> next) {
    requestAction(path, map, OnAction.onNext(next));
  }

  static void requestAction1(
      String path, Map<String, dynamic> map, onNext<dynamic> next, onError e) {
    requestAction(path, map, OnAction.onError(next, e));
  }

  static void requestAction2(String path, Map<String, dynamic> map,
      onNext<dynamic> next, onError e, onComplete c) {
    requestAction(path, map, OnAction.onComplete(next, e, c));
  }

  static void requestAction(
      String path, Map<String, dynamic> map, IOnAction action) {
    _abRequest(path, map, action);
  }
}
