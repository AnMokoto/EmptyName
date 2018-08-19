import 'package:lowlottery/store/AppStore.dart' show AppState, StoreAction;
import 'package:redux/redux.dart';
import 'package:lowlottery/style/index.dart';

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
  final PlayModelItem item;
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

final betReducer = combineReducers<PlayModel>([
  new TypedReducer<PlayModel, LotterBetQuery>((state, action) {
    return new PlayModel()
      ..gameEn = action.gameEn ?? ""
      ..expectNo = action.expectNo ?? "";
  }),
  new TypedReducer<PlayModel, LotterBetAdd>((state, action) {
    state.content..add(action.item);

    return _initContentWithDetail(state);
  }),
  new TypedReducer<PlayModel, LotterBetDelete>((state, action) {
    var data = state.content;
    if (action.index > -1 && action.index < data.length) {
      data.removeAt(action.index);
      state.content = data;
    }
    return _initContentWithDetail(state);
  }),
]);

PlayModel _initContentWithDetail(PlayModel state) {
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
