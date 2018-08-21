import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/net/net.dart' show HttpRetrofit;
import 'dart:async';
import 'dart:io';
import 'package:log/log.dart';

abstract class RegisterIView implements IView {
  void registerSuccess();
}

abstract class LoginIPresenter implements IPresenter<RegisterIView> {
  Future<dynamic> register(Map<String, dynamic> map);
}

class RegisterPresenter extends Presenter<RegisterIView>
    with LoginIPresenter {


  @override
  Future<dynamic> register(Map<String, dynamic> map) {
    Log.message("user regist-------------");
    Log.message(map.toString());
    return HttpRetrofit.request("user/register", map, (data) {
      Log.message("login-------");
      Log.message(data);
    }); 
  }
}
