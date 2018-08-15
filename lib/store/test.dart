library app.redux.test;

import 'AppStore.dart';
import 'package:redux/redux.dart';



/// [store.diapath(TestStoreAction)]
List<Middleware<_AppState>> createAuthMiddleware() {
  return combineTypedMiddleware([
    new MiddlewareBinding<_AppState, TestStoreAction>(
        (store, action, NextDispatcher next) {
      next(action);
    }),
  ]);
}



/// 实际数据转换
/// [TestStoreAction.redurce(AppState)]
class TestReducerLogin {
  static final authReducer = combineTypedReducers<TestAppModel>([
    new ReducerBinding<TestAppModel, TestStoreAction>((state, action) {
      return state;
    })
  ]);
}



class TestStoreAction extends StoreAction {
  @override
  AppState reducer(AppState t) {
    var tt = (t as _AppState).testAppModel;
    (t as _AppState).testAppModel = TestReducerLogin.authReducer(tt, this);
    return t;
  }
}

/// 测试用途
/// Also See:
/// [AppState]
class _AppState extends AppState{
  TestAppModel testAppModel;
}

class TestAppModel extends AppModel {}