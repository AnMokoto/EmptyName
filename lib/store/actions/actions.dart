part of 'index.dart';

/// 原始 [action] 模型
/// action 就是 用来处理数据相关的逻辑
/// 等同于 `m v p` 中的 `p`
/// 事件操作具体的[AppModel]
abstract class StoreAction {
  /// model.reducer
  AppState reducer(AppState t);
}
