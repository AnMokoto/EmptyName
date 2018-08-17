import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/common/mvp.dart';
import 'LotteryContract.dart';
import 'LotteryModel.dart';
import 'LotterState.dart';
import 'package:lowlottery/layout/bet/LotteryBetLayer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:lowlottery/store/AppStore.dart' show AppState;
import 'package:lowlottery/layout/bet/LotteryBetState.dart'
    show LotterBetAdd, LotteryBetModelItem;

import 'dart:async';

/// callback when who preclick the item.
/// [position] item count position
/// [m] anything
typedef void OnLotteryPushClick(dynamic m, int position);

class LotteryLayer extends StatefulWidget {
  @override
  _LotteryState createState() => new _LotteryState(new LotteryPresenter());
}

class _LotteryState extends MVPState<LotteryPresenter, LotteryLayer>
    implements LotteryIView {
  /// 存储选中的数据
  final Map<int, List<dynamic>> _isChoice = Map.identity();
  var money = 0.0;
  var count = 0;

  /// 模拟数据
  ///
  final List _titles = ["万位", "千位", "百位", "十位", "个位"];
  List<List<Map<String, dynamic>>> data;

  _LotteryState(LotteryPresenter presenter) : super(presenter) {
    /// 初始化原有数据
    data = new List.generate(_titles.length, (index) {
      return new List.generate(
        10,
        (position) {
          return {
            "id": position,
            "value": "$position",
            "sub": "",
            "able": false
          };
        },
      );
    });
    _initCacheChoice();
  }

  void _initCacheChoice() {
    for (var index = 0; index < _titles.length; index++) {
      _isChoice[index] = List.generate(10, (i) {
        return -1;
      });
    }
  }

  void _updateCacheChoice(dynamic m, int index) {
    setState(() {
      debugPrint("index==${index}");

      var _id = m["id"];
      var able = data[index][_id]["able"] as bool;

      var _inx = _isChoice[index];
      _inx[_id] = able ? -1 : _id;

      data[index][_id]["able"] = !able;

      var _count = 0;
      _isChoice.forEach((_, value) {
        print(value);
        value.forEach((i) {
          if (i >= 0) {
            ++_count;
          }
        });
      });
      count = _count;
      debugPrint("count==${count}");
      money = count * 2.0;
      debugPrint("money==${money}");
    });
  }

  void _clearCacheChoice() {
    setState(() {
      _initCacheChoice();
    });
  }

  void _onHeadExpansionChoice(int index, bool isChoice) {}

  /// 当前期数信息
  void requestLotteryWithExpectNowSuccess(LotteryModel data) {
    StoreProvider
        .of<AppState>(context)
        .dispatch(new LotteryInitQueryAction(lottery: data));
    // Future.sync(() => {}).whenComplete(() {}).catchError((e) {});
  }

  ///历史档期
  void requestLotteryLastCurrentSuccess(List<Lottery> history) {
    StoreProvider
        .of<AppState>(context)
        .dispatch(new LotteryInitQueryAction(history: history));
  }

  @override
  void initState() {
    super.initState();
    presenter.requestLotteryWithExpectNow();
    presenter.requestLotteryLastCurrent();
  }

  @override
  void didUpdateWidget(LotteryLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var headStyle = const TextStyle(
      fontSize: 15.0,
      color: Colors.black26,
    );

    var _code = new List<String>();
    _isChoice.values.forEach((i) {
      StringBuffer sb = new StringBuffer();
      i.where((f) => f != -1).forEach((r) {
        sb.write(r);
        sb.write(" ");
      });

      if (sb.isEmpty) {
        _code.add("-");
        sb.clear();
      } else {
        var str = sb.toString();
        _code.add(str.substring(0, str.lastIndexOf(" ")));
      }
    });

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("data"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {},
          )
        ],
      ),
      // child: new Container(
      //     padding: EdgeInsets.all(10.0),
      //     child: new ListView.custom(
      //         childrenDelegate:
      //             new SliverChildBuilderDelegate((context, index) {
      //       return new LotteryItem(
      //         this._titles[index],
      //         index,
      //         items: new List.generate(10, (i) {
      //           return {i: ""};
      //         }),
      //       );
      //     }, childCount: _titles.length))),
      backgroundColor: Colors.white,
      body: new Container(
          padding: EdgeInsets.all(2.0),
          constraints: new BoxConstraints.expand(),
          child: new Column(
            children: <Widget>[
              /// header
              new Container(
                color: Colors.brown[200],
                child: new Row(children: <Widget>[
                  // child: new Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 10.0, vertical: 5.0),
                  new Expanded(
                    child: new Container(
                        child: new StoreConnector<AppState, LotteryState>(
                      builder: (context, state) {
                        return new Column(
                          children: <Widget>[
                            new Text(
                              (state.history != null
                                      ? (state.history.length > 0
                                          ? state.history[0].expectNo ?? ""
                                          : "")
                                      : "") +
                                  "期开奖号码",
                              style: headStyle,
                            ),
                            new Container(
                              child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: new List.generate(_titles.length,
                                      (index) {
                                    var _str = (state.history.length > 0
                                            ? (state.history[0].opencode
                                                    as String) ??
                                                ""
                                            : "")
                                        .split(",");
                                    print(_str);
                                    return new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            new BoxShadow(
                                                color: Colors.black26,
                                                offset: const Offset(2.0, 2.0)),
                                          ]),
                                      width: 30.0,
                                      height: 30.0,
                                      child: new Center(
                                        child: new Text(
                                          _str.length > 1 ? _str[index] : "-",
                                          // _str[index] ?? "-",
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                          ],
                        );
                      },
                      converter: (state) {
                        return state.state.lottery;
                      },
                    )),
                  ),

                  // new Container(
                  //   width: 1.0,
                  //   height: double.infinity,
                  //   color: Colors.grey[200],
                  //   // constraints: const BoxConstraints.tightFor(),
                  //   //   decoration: new BoxDecoration(
                  //   //       border: new Border(
                  //   //           left: new BorderSide(
                  //   //               width: 1.0, color: Colors.grey[200]))),
                  // ),
                  new Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: new Container(
                      color: Colors.grey,
                      width: 1.0,
                      height: 50.0,
                    ),
                  ),
// new SizedBox()
                  new Expanded(
                    child: new Container(
                        child: new StoreConnector<AppState, Lottery>(
                      builder: (context, state) {
                        return new Column(
                          children: <Widget>[
                            new Text(
                              "${state==null?"":state.expectNo??""}期投注截止",
                              style: headStyle,
                            ),

                            new Container(
                              margin: EdgeInsets.all(4.0),
                              child: new Text(
                                //data
                                "--:--:--",
                                style: headStyle,
                              ),
                            )
                            //new Spacer(),
                          ],
                        );
                      },
                      converter: (state) {
                        return state.state.lottery.lottery;
                      },
                    )),
                  ),
                ]),
              ),

              /// list
              new Expanded(
                child: new Container(
                  child: new CustomScrollView(
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    slivers: <Widget>[
                      new SliverPadding(
                        padding: EdgeInsets.all(10.0),
                        sliver: new SliverPersistentHeader(
                          delegate:
                              new LotteryHeadSliverPersistentHeaderDelegate(
                                  money: money),
                          pinned: false,
                          floating: false,
                        ),
                      ),
                      new SliverPadding(
                        padding: EdgeInsets.all(10.0),
                        sliver: new SliverList(
                          delegate: new SliverChildBuilderDelegate(
                            (context, index) {
                              return new Column(
                                children: <Widget>[
                                  new LotteryItem(
                                    this._titles[index] ?? "a",
                                    index,
                                    items: data[index],
                                    callback: _updateCacheChoice,
                                  ),
                                  new Divider(),
                                ],
                              );
                            },
                            childCount: _titles.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// footer
              new Container(
                color: Colors.white,
                constraints: new BoxConstraints.tightFor(),
                child: new Offstage(
                  offstage: count <= 0,
                  child: new Container(
                    height: 80.0,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                                constraints: new BoxConstraints.expand(),
                                color: Colors.red,
                                child: new Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new IconButton(
                                        icon: new Icon(
                                          Icons.add,
                                          size: 40.0,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return new AlertDialog(
                                                title: new Text("data"),
                                              ).build(context);
                                            },
                                          );
                                        },
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(left: 15.0),
                                        constraints:
                                            new BoxConstraints.tightForFinite(),
                                        child: new Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new SafeArea(
                                              child: new Text(
                                                "共${count}注，${money}元",
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                ),
                                              ),
                                            ),
                                            new Container(
                                              constraints: new BoxConstraints(
                                                  maxWidth: 200.0),
                                              child: new Text(
                                                  _code.toString().replaceAll(
                                                          new RegExp(
                                                              r"(\]|\[)*"),
                                                          "") ??
                                                      "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                        new ConstrainedBox(
                          constraints:
                              new BoxConstraints(minHeight: double.infinity),
                          child: new RaisedButton.icon(
                            textColor: Colors.white,
                            elevation: 0.0,
                            // highlightColor: Colors.transparent,
                            // splashColor: Colors.transparent,
                            color: Colors.black87,
                            label: new Text("号码篮"),
                            icon: new Icon(Icons.card_giftcard),
                            onPressed: () {
                              /// turn to pay layer
                              StoreProvider.of<AppState>(context).dispatch(
                                  new LotterBetAdd(
                                      item: new LotteryBetModelItem(
                                          code: _code,
                                          zhushu: count,
                                          money: money,
                                          playEn: "1xfx")));
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => new LotteryBetLayer()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class LotteryHeadSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  dynamic money;

  LotteryHeadSliverPersistentHeaderDelegate({this.money});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SafeArea(
      child: new Semantics(
        child: new Text(
          "从万位、千位、百位,十位、个位任意位置上至少选择1个号码，号码与相同位置的开奖号码一致。励现金${money}元",
          style: const TextStyle(color: Colors.black),
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

class LotteryItem extends StatefulWidget {
  final String title;
  final int position;
  final List<Map<String, dynamic>> items;
  final OnLotteryPushClick callback;

  LotteryItem(this.title, this.position, {Key key, this.items, this.callback})
      : assert(title != null),
        assert(items != null),
        super(key: key);

  _LotteryItemState createState() => new _LotteryItemState();
}

class _LotteryItemState extends State<LotteryItem> {
  @override
  Widget build(BuildContext context) {
    var value = widget.items;
    return new Container(
      constraints: new BoxConstraints.tightFor(),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// left
          new Container(
            width: 50.0,
            height: 30.0,
            decoration: new BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: new Center(
              child: new Text(
                widget.title ?? "",
                style: new TextStyle(
                  color: Colors.red[200],
                  fontSize: 13.0,
                ),
                maxLines: 1,
              ),
            ),
            margin: EdgeInsets.only(right: 20.0),
          ),

          /// right
          new Expanded(
            child: new Container(
              constraints: new BoxConstraints(maxHeight: 120.0),
              child: new GridView.count(
                  //controller: new FixedExtentScrollController(),
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  scrollDirection: Axis.vertical,
                  children: new List.generate(widget.items.length, (index) {
                    return new Container(
                        // color: value["able"] as bool
                        //     ? Colors.red[400]
                        //     : Colors.green[100],
                        alignment: Alignment.center,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ///数字按钮
                            new Container(
                              constraints: new BoxConstraints(
                                  minWidth: 50.0, minHeight: 50.0),
                              decoration: new BoxDecoration(
                                  color: value[index]["able"] as bool
                                      ? Colors.red[400]
                                      : Colors.grey[300],
                                  shape: BoxShape.circle),
                              child: new InkWell(
                                  child: new Center(
                                    child: new Text(
                                      value[index]["value"] ?? "",
                                      maxLines: 1,
                                      style: new TextStyle(
                                          color: (value[index]["able"])
                                              ? Colors.white
                                              : Colors.red[400],
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  onTap: () {
                                    widget.callback(
                                      value[index],
                                      widget.position,
                                    );
                                  }),
                            ),

                            /// 预留位置
                            // new Text(
                            //   (value["sub"] as String) ?? "1",
                            // )
                          ],
                        ));
                  })),
            ),
          )
        ],
      ),
    );
  }
}
