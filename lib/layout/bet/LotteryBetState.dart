import 'package:lowlottery/store/AppStore.dart'
    show AppState, AppModel, StoreAction;
import 'package:redux/redux.dart';

/////////
/// @author An'Mokoto
/// [bet] 下注的数字 [0,1,-,-,-] 共计 五位
/// 其中 `Value` 每一位置区间长度`(0-10]`, 长度为 `-` 时表示 `0`
/// @desc 玩法 注数 x 单注价格 x 倍数 = Total
//////// 一下数据为用户选择的数据

// {
// expectNo (string): 当前期号 ,
// gameEn (string): 彩种编码 ,
// money (number): 方案总金额 ,
// zhushu (integer): 方案总注数 ,
// content (Array[ProjectContent])
// }
class LotteryBetModel extends AppModel {
  String gameEn;
  String expectNo;
  String money;
  int zhushu;
  List<LotteryBetModelItem> content;

  LotteryBetModel() {
    this.content = [new LotteryBetModelItem(), new LotteryBetModelItem()];
  }
}

// {
// beishu (integer): 倍数 ,
// code (string): 当前用户选号 ,
// money (number): 购彩金额 ,
// playEn (string): 玩法编码 ,
// zhushu (integer): 购彩注数
// }
class LotteryBetModelItem extends Object {
  List<String> code = ["1", "1", "1", "1", "1"];
  double beishu = 1.0;
  String playEn;
  int zhushu = 0;
  double money = 0.0;
}

///// action
///
class LotterBetDelete extends StoreAction {
  int index;

  LotterBetDelete({int index: -1}) {
    this.index = index;
  }

  @override
  AppState reducer(AppState t) {
    t.betModel = betReducer(t.betModel, this);
    return t;
  }
}

class LotterBetAdd extends StoreAction {
  final LotteryBetModelItem item;
  LotterBetAdd({this.item});

  @override
  AppState reducer(AppState t) {
    t.betModel = betReducer(t.betModel, this);
    return t;
  }
}

class LotterBetQuery extends StoreAction {
  @override
  AppState reducer(AppState t) {
    t.betModel = betReducer(null, this);
    return t;
  }
}

/// reducer
//

final betReducer = combineReducers<LotteryBetModel>([
  new TypedReducer<LotteryBetModel, LotterBetQuery>((state, action) {
    if (state == null) {
      state = new LotteryBetModel();
    }
    return state;
  }),
  new TypedReducer<LotteryBetModel, LotterBetAdd>((state, action) {
    state.content..add(action.item);
    return state;
  }),
  new TypedReducer<LotteryBetModel, LotterBetDelete>((state, action) {
    var data = state.content;
    if (action.index > -1 && action.index < data.length) {
      data.removeAt(action.index);
      state.content = data;
    }
    return state;
  }),
]);
