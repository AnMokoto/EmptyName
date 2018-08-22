import 'package:lowlottery/common/mvp.dart';
import 'dart:async';
import 'package:lowlottery/net/HttpRetrofit.dart';

abstract class LotterBetRecordIVew extends IView {}

class LotterBetRecordPresenter extends Presenter<LotterBetRecordIVew> {}

abstract class OpencodeRecordFragIVew extends IView {
  void requestBetRecordSuccess(List<dynamic> data);
}

class OpencodeRecordFragPresenter extends Presenter<OpencodeRecordFragIVew> {
  Future<dynamic> opencodeList() {
    return HttpRetrofit.requestError(
        "allLotOpencodeList", {"pageIndex": 0, "pageSize": 100}, (data) {
      ////
      print("userProjectList------------");
//      print(data);
      view.requestBetRecordSuccess(data);
    }, (e) => NetIView.OnError(view.context, e));
  }
}

abstract class LotterBetRecordDetailIVew extends IView {
  void requestDetailsSuccess(Map<String, dynamic> map);
}

class LotterBetRecordDetailPresenter
    extends Presenter<LotterBetRecordDetailIVew> {
  Future<dynamic> requestDetails(String projectEn) {
    return HttpRetrofit
        .requestError("allLotOpencodeList", {}, (data) {
      print(data);
      view.requestDetailsSuccess(data);
    }, (e) => NetIView.OnError(view.context, e));
  }
}
