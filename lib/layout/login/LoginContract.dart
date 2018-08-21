import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/net/net.dart' show HttpRetrofit;
import 'dart:async';
import 'dart:io';
import 'package:lowlottery/log.dart';

abstract class LoginBetIView implements IView {
}

abstract class LoginIPresenter implements IPresenter<LoginBetIView> {
  Future<dynamic> login(Map<String, dynamic> map);
}

class LoginPresenter extends Presenter<LoginBetIView>
    with LoginIPresenter {


  @override
  Future<dynamic> login(Map<String, dynamic> map) {
    Log.message("user login-------------");
    Log.message(map.toString());
    return HttpRetrofit.request("user/login", map, (data) {
      Log.message("login-------");
      Log.message(data);
    });
  }
}
