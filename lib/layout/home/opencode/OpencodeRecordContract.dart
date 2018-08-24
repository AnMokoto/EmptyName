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

abstract class LotOpencodelistIVew extends IView {
  void requestDetailsSuccess(List<dynamic> list);
}

class LotOpencodeDetailPresenter extends Presenter<LotOpencodelistIVew> {
  Future<dynamic> requestDetails(String projectEn) {
    print(projectEn);
    return HttpRetrofit.requestError("allLotOpencodeList", {}, (data) {
      print(data);
      view.requestDetailsSuccess(data);
    }, (e) => NetIView.OnError(view.context, e));
  }
}
