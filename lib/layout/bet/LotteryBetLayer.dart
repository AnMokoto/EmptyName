import 'package:flutter/material.dart';
import 'LotteryBetContract.dart';
import 'package:lowlottery/common/mvp.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:lowlottery/store/AppStore.dart' show AppState;
import 'LotteryBetState.dart';
import 'package:lowlottery/style/index.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

/// 立即下注界面
class LotteryBetLayer extends StatefulWidget {
  @override
  _LotteryState createState() => new _LotteryState(new LotteryBetPresenter());
}

class _LotteryState extends MVPState<LotteryBetPresenter, LotteryBetLayer>
    with LotteryBetIView {
  _LotteryState(LotteryBetPresenter p) : super(p);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void requestWhenwhohasreallytoPaySuccess(dynamic data) {
    var style = new TextStyle(fontSize: 10.0, color: Colors.lightBlue);
    showDialog(
      context: context,
      builder: (context) => new CupertinoAlertDialog(
            title: new Text("title"),
            content: new Text("success"),
            actions: <Widget>[
              new CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  //this.dispose();
                  Navigator.of(context).pop();
                },
                child: new Text(
                  "left",
                  style: style,
                ),
              ),
              new CupertinoDialogAction(
                onPressed: () {
                  //this.dispose();
                  Navigator.of(context).pop();
                },
                child: new Text(
                  "right",
                  style: style,
                ),
              ),
            ],
          ),
    );
  }

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
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: new StoreConnector<AppState, PlayModel>(
                  builder: (context, PlayModel model) {
                    print("model====");
                    print(model.content);
                    return new CustomScrollView(
                      controller: new ScrollController(keepScrollOffset: true),
                      shrinkWrap: true,

                      /// 界面
                      slivers: <Widget>[
                        /// header
                        new SliverPersistentHeader(
                          delegate:
                              new LotterBetSliverPersistentHeaderDelegate(),
                          pinned: false,
                          floating: false,
                        ),

                        /// list
                        new SliverPadding(
                          /// 这里没有设置背景
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          sliver: new SliverFixedExtentList(
                            itemExtent: 70.0,

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
                                          // contentPadding: EdgeInsets.all(10.0),
                                          title: new Text(
                                            data.code ?? "",
                                            style: new TextStyle(
                                                color: Colors.red[800],
                                                fontSize: 15.0),
                                          ),
                                          subtitle: new Text(
                                            ///x${model.beishu}倍
                                            "${data.playEn} ${data.zhushu}注x${AppState.price}元 = ${data.money}元 ",

                                            style: new TextStyle(
                                                color: Colors.black45 ,fontSize: 15.0),
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

                        new SliverToBoxAdapter(
                          child: new Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: new Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        /// list 底部操作栏
                        new SliverToBoxAdapter(
                          child: new Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: new Container(
                              height: 50.0,
                              color: Colors.orange,
                              child: new Text("afeeeeeeeeee"),
                            ),
                          ),
                        )
                        // new Text("data")
                      ],
                    );
                  },
                  converter: (Store<AppState> store) {
                    return store.state.betModel;
                  },
                ),
              ),
              new Container(
                constraints: new BoxConstraints.tightFor(),
                child: new StoreConnector<AppState, PlayModel>(
                  builder: (context, model) {
                    print("-----------------------------");
                    print(model.toString());
                    print("-----------------------------");
                    var isOffset =
                        model.content == null || model.content.length <= 0;
                    return new Offstage(
                      offstage: isOffset,
                      child: new Container(
                        height: 55.0,
                        color: Colors.transparent,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                color: Colors.black87,
                                padding: EdgeInsets.all(5.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // new Semantics()
                                    new SafeArea(
                                      child: new Text(
                                        "方案 ${model.zhushu}注,${model.money}元",
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    ),

                                    new SafeArea(
                                      child: new Text(
                                        "普通投注",
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white70),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            new Container(
                              // color: Colors.red,
                              constraints: new BoxConstraints(
                                  minHeight: double.infinity),
                              child: new RaisedButton(
                                color: Colors.red,
                                shape: null,
                                textColor: Colors.white,
                                child: new Text(
                                  "立即投注",
                                  style: new TextStyle(fontSize: 18.0),
                                ),
                                onPressed: () {
                                  /// 立即投注
                                  presenter
                                      .requestWhenwhohasreallytoAdd(
                                          model.toMap())
                                      .then((e) {
                                    ////
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  converter: (store) {
                    return store.state.betModel;
                  },
                ),
              )
            ],
          )),
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
                    if (index == 2) {
                      Navigator.of(context).pop();
                    }
                  });
            })),
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

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
