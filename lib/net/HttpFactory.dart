import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

const dynamic HOST_NAME = "";

typedef void onComplete();

typedef void onError(Exception e);

typedef void onNext(dynamic t);
