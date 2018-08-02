import 'package:lowlottery/common/mvp.dart';

class HomeIView extends IView {}

class HomePresenter extends Presenter<HomeIView> {
  HomePresenter(HomeIView view) : super(view);
}
