import 'package:lowlottery/common/mvp.dart';

abstract class IndexFragIView extends IView {}

abstract class IndexFragIPresenter extends IPresenter<IndexFragIView> {
  void requestIndexFragLottery();
}

class IndexFragPresenter extends Presenter<IndexFragIView>
    implements IndexFragIPresenter {
  IndexFragPresenter(IndexFragIView view) : super(view);

  @override
  void requestIndexFragLottery() {}
}
