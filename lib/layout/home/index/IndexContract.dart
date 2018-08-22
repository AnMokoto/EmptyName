import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/net/net.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

abstract class IndexFragIView extends IView {
  void requestIndexFragLotterySuccess(List<FixBoxModel> data);
}

abstract class IndexFragIPresenter extends IPresenter<IndexFragIView> {
  void requestIndexFragLottery();
}

class IndexFragPresenter extends Presenter<IndexFragIView>
    implements IndexFragIPresenter {
  IndexFragPresenter() : super();

  @override
  void requestIndexFragLottery() {
    HttpRetrofit.request("lotConfig", {}, (model) {
      /// 未做错误处理
      var data = FixBoxModel.fromJsonToList(model);
      view?.requestIndexFragLotterySuccess(data);
    });
  }
}
