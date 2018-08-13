library httpfactory;

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:lowlottery/common/models.dart';

const dynamic HOST_NAME = "http://178.128.21.119:10003/";
/// REQUEST - RESPONSE FINISH .
typedef void onComplete();

/// REQUEST FAILURE . ALSE SEE [Exception]
typedef void onError(Exception e);

/// REQUEST SUCCESS . ALSE SEE [IModel]
typedef void onNext<T>(T t);

abstract class IOnAction<T> {
  /// 数据请求成功后的数据

  void OnNext(T t) {}

  /// 请求失败

  void OnError(Exception e) {}

  /// 请求完成

  void OnComplete() {}
}

class OnAction<T> implements IOnAction<T> {
  onNext next;
  onError error;

  onComplete c;

  factory OnAction.onNext(onNext next) {
    return OnAction.onError(next, (e) {});
  }

  factory OnAction.onError(onNext next, onError error) {
    return OnAction.onComplete(next, error, () {});
  }

  factory OnAction.onComplete(onNext next, onError error, onComplete complete) {
    return new OnAction(next, error, complete);
  }

  OnAction(onNext next, onError error, onComplete complete) {
    this.next = next;
    this.error = error;
    this.c = complete;
  }

  @override
  void OnNext(T t) {
    print("onNext");
    this.next(t);
  }

  @override
  void OnError(Exception e) {
    print("onError");
    this.error(e);
  }

  @override
  void OnComplete() {
    print("onComplete");
    this.c();
  }
}

const REQUEST_HEAD = {
  "Content-Type": "application/json",
  "Accept": "application/json"
};

void _abRequest(String path, Map<String, dynamic> map, IOnAction action) {
  // var request = new http.Request("POST", Uri.parse(HOST_NAME + path));
  // request.body = json.encode(map);
  // request.headers["Content-Type"] = "application/json";
  // request.headers["Accept"] = "application/json";
  // var _client = new http.Client();
  print(map.toString());
  var url = HOST_NAME + path;
  print(url);
  http
      .post(url, headers: REQUEST_HEAD, body: json.encode(map))
      // _client
      // .send(request)
      //.post(HOST_NAME+path, body: map)
      .timeout(Duration(milliseconds: 1000 * 10), onTimeout: () {})
      .then((response) {
    var state = response.statusCode;
    if (state == 200) {
      return response.body;
    }
    throw new FormatException("NetWork Error", null, state);
  }).then((response) {
    var body = json.decode(response);
    var success = body['success'] as bool;
    if (success) {
      action.OnNext(body['data']);
      action.OnComplete();
    } else {
      new FormatException(body['message'], null, -1);
    }
    // }).whenComplete(() {
    //  action.onComplete();
  }).catchError((e) {
    print(e);
    //action.OnError(e);
    action.OnComplete();
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
