import 'package:flutter/material.dart';
import 'LotteryBetContract.dart';
import 'package:lowlottery/common/mvp.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:lowlottery/store/AppStore.dart' show AppState;
import 'LotteryBetState.dart';

/// 立即下注界面
class LotteryBetLayer extends StatefulWidget {
  @override
  _LotteryState createState() => new _LotteryState(new LotteryBetPresenter());
}

class _LotteryState extends MVPState<LotteryBetPresenter, LotteryBetLayer>
    with LotteryBetIView {
  _LotteryState(LotteryBetPresenter p) : super(p);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        child: new StoreConnector<AppState, LotteryBetModel>(
          builder: (context, LotteryBetModel model) {
            print("model====");
            print(model.content);
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
                    itemExtent: 210.0,

                    /// 选择的样式
                    delegate: new SliverChildListDelegate(
                      // 创建带划线的ListView
                      ListTile
                          .divideTiles(
                            color: Colors.grey,
                            tiles: new List.generate(
                              model.content.length,
                              (index) {
                                var data = model.content[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.all(10.0),
                                  title: new Text(
                                    data.code.toString() ?? "",
                                    style: new TextStyle(
                                        color: Colors.red[800], fontSize: 12.0),
                                  ),
                                  subtitle: new Text(
                                    "${data.playEn} ${data.zhushu}注x${AppState.price}x${data.beishu} = ${data.money}元",
                                    style: new TextStyle(color: Colors.black45),
                                  ),
                                  trailing: new IconButton(
                                    icon: new Icon(Icons.delete),
                                    onPressed: () {
                                      /// list 中的减号  赋值 [store.dispath(ACTIONS.REMOVE)]
                                      StoreProvider
                                          .of<AppState>(context)
                                          .dispatch(new LotterBetDelete(
                                              index: index));
                                    },
                                  ),
                                  //dense: true,
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

                /// list 底部操作栏
                new SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: new SliverFillRemaining(
                    child: new Row(
                      children: <Widget>[
                        new Text("data"),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          converter: (Store<AppState> store) {
            return store.state.betModel;
          },
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
  double get minExtent => 0.0;

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
