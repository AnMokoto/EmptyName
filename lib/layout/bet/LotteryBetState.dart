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
    this.content = [];
  }

  Map<String, dynamic> toMap() {
    return {
      "gameEn": gameEn,
      "expectNo": expectNo,
      "money": money,
      "zhushu": zhushu,
      "content": content.map((f) => f.toMap()).toList()
    };
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
  List<String> code;
  double beishu;
  String playEn;
  int zhushu;
  double money;

  LotteryBetModelItem(
      {this.code,
      this.beishu: 1.0,
      this.playEn: "",
      this.zhushu: 0,
      this.money: 0.0}) {
    if (this.code == null) {
      this.code = [];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "code": code.toString().replaceAll(new RegExp(r"(\[|\])"), ""),
      //"code":code.toString(),
      "beishu": beishu,
      "playEn": playEn,
      "zhushu": zhushu,
      "money": money
    };
  }
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
  String gameEn;
  String expectNo;
  LotterBetQuery({this.gameEn, this.expectNo});

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
    return new LotteryBetModel()
      ..gameEn = action.gameEn ?? ""
      ..expectNo = action.expectNo ?? "";
  }),
  new TypedReducer<LotteryBetModel, LotterBetAdd>((state, action) {
    state.content..add(action.item);

    return _initContentWithDetail(state);
  }),
  new TypedReducer<LotteryBetModel, LotterBetDelete>((state, action) {
    var data = state.content;
    if (action.index > -1 && action.index < data.length) {
      data.removeAt(action.index);
      state.content = data;
    }
    return _initContentWithDetail(state);
  }),
]);

LotteryBetModel _initContentWithDetail(LotteryBetModel state) {
  var money = 0.0;
  var count = 0;

  state.content.forEach((f) {
    money += f.money;
    count += f.zhushu;
  });
  state.money = money.toString();
  state.zhushu = count;

  return state;
}
