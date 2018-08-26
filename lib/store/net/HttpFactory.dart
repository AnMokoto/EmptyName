library net.factory;

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert' show json;

import 'action.dart';

const dynamic HOST_NAME = "http://178.128.21.119:10003/";

const REQUEST_HEAD = {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "test_token",
};

Future<dynamic> abRequest(
    String path, Map<String, dynamic> map, IOnAction action) async {
  // var request = new http.Request("POST", Uri.parse(HOST_NAME + path));
  // request.body = json.encode(map);
  // request.headers["Content-Type"] = "application/json";
  // request.headers["Accept"] = "application/json";
  // var _client = new http.Client();
  print(map.toString());
  var url = HOST_NAME + path;
  print(url);
  return await http
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
    /// 考虑以下内容移动到action内处理

    var body = json.decode(response);
    var success = body['success'] as bool && body['code'] == 200;
    if (success) {
      action.OnNext(body['data']);
      action.OnComplete();
    } else {
      throw new FormatException(
          "${body['message']}===> ${body['code']}", body, 0);
    }
    // }).whenComplete(() {
    //  action.onComplete();
  }, onError: (e) {
    print(e);
    //action.OnError(e);
    action.OnComplete();
  });
}
