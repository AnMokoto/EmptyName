library net.retrofit;

import 'action.dart';
import 'HttpFactory.dart' as httpfactory;
import 'dart:async';

/// 默认传递POST请求
class HttpRetrofit {
  /// [path] url + path
  /// [map] params
  /// [next] do something when request and response successful.
  static Future<dynamic> request(
      String path, Map<String, dynamic> map, onNext<dynamic> next) {
    return requestAction(path, map, OnAction.onNext(next));
  }

  /// [path] url + path
  /// [map] params
  /// [next] do something when request and response successful.
  /// [e] do something when request and response failure.
  static Future<dynamic> requestError(
      String path, Map<String, dynamic> map, onNext<dynamic> next, onError e) {
    return requestAction(path, map, OnAction.onError(next, e));
  }

  /// [path] url + path
  /// [map] params
  /// [next] do something when request and response successful.
  /// [e] do something when request and response failure.
  /// [c] /// [e] do something when request and response finished.
  static Future<dynamic> requestComplete(String path, Map<String, dynamic> map,
      onNext<dynamic> next, onError e, onComplete c) {
    return requestAction(path, map, OnAction.onComplete(next, e, c));
  }

  /// [path] url + path
  /// [map] params
  /// [action] do something when request and response done.
  static Future<dynamic> requestAction(
      String path, Map<String, dynamic> map, IOnAction action) {
    return httpfactory.abRequest(path, map, action);
  }
}
