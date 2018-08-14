import 'package:flutter/material.dart';
import 'LotteryBetContract.dart';
import 'package:lowlottery/common/mvp.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:lowlottery/state/StoreAction.dart';
import 'state/LotteryBetState.dart';

LotteryBetState mainReducer(LotteryBetState state, dynamic action) {
  return state.reducer(action);
}

Store<LotteryBetState> store = new Store<LotteryBetState>(
  mainReducer,
  initialState: new LotteryBetState(
    bet: new List(),
  ),
);

/// 立即下注界面
class LotteryBetLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new _LotteryBetLayer(store: store);
  }
}

class _LotteryBetLayer extends StatefulWidget {
  /// 当
  final Store store;
  _LotteryBetLayer({Key key, this.store})
      : assert(store != null),
        super(key: key);

  _LotteryState createState() => new _LotteryState(new LotteryBetPresenter());
}

class _LotteryState extends MVPState<LotteryBetPresenter, _LotteryBetLayer>
    with LotteryBetIView {
  _LotteryState(LotteryBetPresenter p) : super(p);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: widget.store,
      child: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "号码篮",
            style: new TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: new Container(
          //padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.grey[100],
          child: new StoreConnector(
            builder: (context, LotteryBetState model) {
              return new CustomScrollView(
                /// 界面
                slivers: <Widget>[
                  /// header
                  new SliverPersistentHeader(
                    delegate: new LotterBetSliverPersistentHeaderDelegate(),
                    pinned: true,
                    floating: true,
                  ),

                  /// list
                  new SliverPadding(
                  /// 这里没有设置背景
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    sliver: new SliverFixedExtentList(
                      itemExtent: 110.0,
                      /// 选择的样式
                      delegate: new SliverChildListDelegate(
                        // 创建带划线的ListView
                        ListTile.divideTiles(
                          color: Colors.grey,
                          tiles: new List.generate(
                            model.bet.length,
                            (index) {
                              var data = model.query(index);
                              return ListTile(
                                contentPadding: EdgeInsets.all(10.0),
                                title: new Text(data["nums"]),
                                subtitle: new Text(data["desc"]),
                                trailing: new IconButton(
                                  icon: new Icon(Icons.delete),
                                  onPressed: () {
                                    /// list 中的减号  赋值 [store.dispath(ACTIONS.REMOVE)]
                                    store.dispatch(new StoreData(
                                        actions: ACTIONS.REMOVE, index: index));
                                  },
                                ),
                                //dense: true,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// list 底部操作栏
                  new SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    sliver: new Row(
                      children: <Widget>[],
                    ),
                  )
                ],
              );
            },
            converter: (Store<LotteryBetState> store) {
              return store.state;
            },
          ),
        ),
      ),
    );
  }
}

/// 顶部操作按钮 悬浮
class LotterBetSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final List header = ["机选1注", "机选5注", "继续选号"];
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return new SafeArea(
      child: new Container(
        ///header
        constraints: new BoxConstraints.tightFor(),
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            /// 顶部三块
            children: new List.generate(header.length, (index) {
              return _LotteryBetPress(
                  title: header[index],
                  onPress: () {
                    /// 三块不同的点击事件
                  });
            })),
      ),
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => double.nan;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _LotteryBetPress extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  _LotteryBetPress({Key key, this.title, this.onPress})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RaisedButton.icon(
      color: Colors.white,
      textColor: Colors.black,
      disabledColor: Colors.deepOrange,
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          side: new BorderSide(
            color: Colors.grey[100],
          )),
      label: new Text(title),
      icon: new Icon(Icons.add),
      onPressed: onPress,
    );
  }
}
