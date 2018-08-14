library lottery.redux.action;

/// 数据传递类型
enum ACTIONS { INSERT, UPDATE, REMOVE, QUERY,CLEAR }

/// 数据操作分类
abstract class StateAction<T> {
  void insert(int index,T t);

  void update(int index, T t);

  T remove(int index);

  T query(int index);

  void clear();

  /// [action] default [ACTIONS] else custom.
  /// default it's self or other.
  dynamic reducer(StoreData action);
}

/// 数据传递类
class StoreData {
  int index;
  dynamic data;
  ACTIONS actions;

  StoreData({this.actions, this.data, this.index: -1})
      : assert(actions != null);
}
