library net.retrofit;
import 'action.dart';
import 'HttpFactory.dart' as httpfactory;

/// 默认传递POST请求
class HttpRetrofit {

  /// [path] url + path
  /// [map] params
  /// [next] do something when request and response successful.
  static void request(
      String path, Map<String, dynamic> map, onNext<dynamic> next) {
    requestAction(path, map, OnAction.onNext(next));
  }
  /// [path] url + path
  /// [map] params
  /// [next] do something when request and response successful.
  /// [e] do something when request and response failure.
  static void requestAction1(
      String path, Map<String, dynamic> map, onNext<dynamic> next, onError e) {
    requestAction(path, map, OnAction.onError(next, e));
  }
  /// [path] url + path
  /// [map] params
  /// [next] do something when request and response successful.
  /// [e] do something when request and response failure.
  /// [c] /// [e] do something when request and response finished.
  static void requestAction2(String path, Map<String, dynamic> map,
      onNext<dynamic> next, onError e, onComplete c) {
    requestAction(path, map, OnAction.onComplete(next, e, c));
  }
  /// [path] url + path
  /// [map] params
  /// [action] do something when request and response done.
  static void requestAction(
      String path, Map<String, dynamic> map, IOnAction action) {
    httpfactory.abRequest(path, map, action);
  }
}
