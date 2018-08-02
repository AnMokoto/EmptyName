library httpfactory;

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:lowlottery/common/models.dart';

const dynamic HOST_NAME = "";

typedef void onComplete();

typedef void onError(Exception e);

typedef void onNext<T>(IModel<T> t);
