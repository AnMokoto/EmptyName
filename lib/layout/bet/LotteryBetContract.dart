import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/net/net.dart' show HttpRetrofit;
import 'dart:async';
import 'dart:io';
import 'package:log/log.dart';

abstract class LotteryBetIView implements IView {}

abstract class LotteryBetIPresenter implements IPresenter<LotteryBetIView> {
  void requestWhenwhohasreallytoPay(Map<String, dynamic> map);
  void requestWhenwhohasreallytoAdd(Map<String, dynamic> map);
}

class LotteryBetPresenter extends Presenter<LotteryBetIView>
    with LotteryBetIPresenter {
  @override
  void requestWhenwhohasreallytoPay(Map<String, dynamic> map) {
    HttpRetrofit.request("path", map, (data) {});
  }

  @override
  void requestWhenwhohasreallytoAdd(Map<String, dynamic> map) {
    Log.message("ssfewwwwwwww");
    Log.message(map.toString());
    HttpRetrofit.request("projectAdd", map, (data) {
      Log.message(data);
    });
  }
}
