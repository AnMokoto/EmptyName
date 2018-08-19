import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/net/net.dart' show HttpRetrofit;
import 'dart:async';
import 'dart:io';
import 'package:log/log.dart';

abstract class LotteryBetIView implements IView {
  void requestWhenwhohasreallytoPaySuccess(dynamic data);
}

abstract class LotteryBetIPresenter implements IPresenter<LotteryBetIView> {
  void _requestWhenwhohasreallytoPay(Map<String, dynamic> map);
  Future<dynamic> requestWhenwhohasreallytoAdd(Map<String, dynamic> map);
}

class LotteryBetPresenter extends Presenter<LotteryBetIView>
    with LotteryBetIPresenter {
  @override
  void _requestWhenwhohasreallytoPay(Map<String, dynamic> map) {
    Log.message("requestWhenwhohasreallytoPay-------------");
    Log.message(map.toString());
    HttpRetrofit.request("projectPay", map, (data) {
      Log.message("projectPay-------------");
      Log.message(data);
      view.requestWhenwhohasreallytoPaySuccess(data);
    });
  }

  @override
  Future<dynamic> requestWhenwhohasreallytoAdd(Map<String, dynamic> map) {
    Log.message("requestWhenwhohasreallytoAdd-------------");
    Log.message(map.toString());
    return HttpRetrofit.request("projectAdd", map, (data) {
      Log.message("projectAdd-------");
      Log.message(data);
      _requestWhenwhohasreallytoPay({"projectEn": data["projectEn"]});
    });
  }
}
