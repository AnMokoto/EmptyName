import 'package:flutter/material.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lowlottery/conf/LotPlay.dart';
import 'package:lowlottery/style/index.dart';

/// 立即下注界面,号码篮
@immutable
class LotteryBetLayer extends StatefulWidget {
  final PlayStyle style;
  LotteryBetLayer({this.style});

  @override
  _LotteryState createState() => new _LotteryState();
}

class _LotteryState extends State<LotteryBetLayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    return new CustomScrollView(
                      controller: new ScrollController(keepScrollOffset: true),
                      shrinkWrap: true,

                      /// 界面
                      slivers: <Widget>[
                        /// header
                        new SliverPersistentHeader(
                          delegate: new LotterBetSliverPersistentHeaderDelegate(
                              style: widget.style),
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

                              ListTile.divideTiles(
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
                                            fontSize: 17.0),
                                      ),
                                      subtitle: new Text(
                                        ///x${model.beishu}倍
                                        LotPlayConfig.getName(
                                                "${data.playEn}") +
                                            "  ${data.zhushu}注x${AppState.price}元 = ${data.money}元 ",

                                        style: new TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13.0),
                                      ),
                                      trailing: new IconButton(
                                        icon: new Icon(Icons.delete),
                                        onPressed: () {
                                          /// list 中的减号  赋值 [store.dispath(ACTIONS.REMOVE)]
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(new LotterBetDelete(
                                                  index: index));
                                        },
                                      ),
                                      //dense: true,
                                    );
                                  },
                                ),
                              ).toList(),
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
                    var isOffset =
                        model.content == null || model.content.length <= 0;
                    return new Container(
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
                                      "方案 ${model.zhushu ?? 0}注,${model.money ?? 0}元",
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                          fontSize: 15.0, color: Colors.white),
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
                            constraints:
                                new BoxConstraints(minHeight: double.infinity),
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
                                dispatch(
                                    context,
                                    new LotterBetRequestAction(
                                        context, model.toMap()));
                              },
                            ),
                          )
                        ],
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
@immutable
class LotterBetSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final List header = ["机选1注", "机选5注", "继续选号"];

  final PlayStyle style;
  LotterBetSliverPersistentHeaderDelegate({this.style}) : assert(style != null);

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
          children: new List.generate(
            header.length,
            (index) {
              return _LotteryBetPress(
                title: header[index],
                onPress: () {
                  /// 三块不同的点击事件
                  if (index == 2) {
                    Navigator.of(context).pop();
                  } else {
                    dispatch(
                        context,
                        LotteryRandomAction(
                            items: style.randomType(index == 1 ? 5 : 1)));
                  }
                },
              );
            },
          ),
        ),
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
      textColor: Colors.black54,
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
