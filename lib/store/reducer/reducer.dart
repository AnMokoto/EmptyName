part of 'index.dart';

/// 数据转换控制
/// 数据调度控制
class AppReducer {
  static AppState reducer(AppState state, StoreAction action) {
    ///  model.reducer
    return action.reducer(state);
  }
}

