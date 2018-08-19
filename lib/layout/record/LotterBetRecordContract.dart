import 'package:lowlottery/common/mvp.dart';
import 'dart:async';
import 'package:lowlottery/net/HttpRetrofit.dart';

abstract class LotterBetRecordIVew extends IView {}

class LotterBetRecordPresenter extends Presenter<LotterBetRecordIVew> {}

abstract class LotterBetRecordFragIVew extends IView {
  void requestBetRecordSuccess(List<dynamic> data);
}

class LotterBetRecordFragPresenter extends Presenter<LotterBetRecordFragIVew> {
  Future<dynamic> requestBetRecord(String type) {
    return HttpRetrofit.requestError(
        "userProjectList", {"pageIndex": 0, "pageSize": 100}, (data) {
      ////
      print("userProjectList------------");
      print(data);
      view.requestBetRecordSuccess(data["dataList"]);
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
        .requestError("projectDetail", {"projectEn": projectEn ?? ""}, (data) {
      print("projectDetail------------");
      print(data);
      view.requestDetailsSuccess(data);
    }, (e) => NetIView.OnError(view.context, e));
  }
}
