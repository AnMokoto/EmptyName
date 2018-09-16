library net.factory;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

@protected
class HttpRetrofit {
  final String host;
  Duration duration;
  Map<String, dynamic> headers;

  HttpRetrofit(
      {this.host, this.duration: const Duration(seconds: 60)})
      : assert(host != null && host.isNotEmpty) {
    headers = new Map.from({
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "test_token",
    });
  }

  factory HttpRetrofit.from(String host) => new HttpRetrofit(host: host);

  Future<http.Response> post({String path, Map<String, dynamic> body}) async {
    print("--path=$path\n--headers=$headers\n--body=$body");
    return await http
        .post(host + path,
            headers: new Map.from(headers), body: json.encode(body))
        .timeout(duration);
  }

  Future<dynamic> addHeaders({String key, String value}) async {
    this.headers[key] = value;
    return this.headers;
  }

  Future<dynamic> setHeaders(Map<String, dynamic> headers) async {
    this.headers = new Map.from(headers);
    return this.headers;
  }
}
