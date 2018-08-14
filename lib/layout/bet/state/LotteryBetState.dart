import 'package:lowlottery/state/state.dart';

/// @author An'Mokoto
/// [bet] 下注的数字 [0,1,-,-,-] 共计 五位
/// 其中 `Value` 每一位置区间长度`(0-10]`, 长度为 `-` 时表示 `0`
/// @desc 玩法 注数 x 单注价格 x 倍数 = Total
///
class LotteryBetState implements StateAction<dynamic> {
  ///当前选中的等待立即下注的集合
  List<Map<String, dynamic>> bet;

  LotteryBetState({this.bet}) : assert(bet != null);

  void insert(int index, dynamic t) => bet.insert(index, t);

  void update(int index, dynamic t) => bet[index] = t;

  dynamic remove(int index) => bet.removeAt(index);

  dynamic query(int index) => bet[index];

  void clear() => bet.clear();

  @override
  dynamic reducer(StoreData action) {
    switch (action.actions) {
      case ACTIONS.REMOVE:
        return remove(action.index);
      case ACTIONS.INSERT:
        return insert(action.index, action.data);
      default:
        return this;
    }
  }
}
