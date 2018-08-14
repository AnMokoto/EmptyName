import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/common/mvp.dart';
import 'LotteryContract.dart';
import 'LotteryModel.dart';

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
  ///当前期数信息
  var currentNum = "0805041";

  /// 倒计时时间
  var currentNumEnding = -1;

  /// 上期开奖号码
  var lastCurrentLotteryNum = 0;
  final List<Lottery> history = new List();

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
      _inx[_id] = able ? -1 : index;

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
    setState(() {
      currentNum = data.expectNo ?? "";
      currentNumEnding = data.remainTime;
    });
  }

  ///历史档期
  void requestLotteryLastCurrentSuccess(List<Lottery> history) {
    setState(() {
      this.history.clear();
      this.history.addAll(history);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter.requestLotteryWithExpectNow();
    presenter.requestLotteryLastCurrent();
  }

  @override
  void didUpdateWidget(LotteryLayer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var headStyle = const TextStyle(
      fontSize: 12.0,
      color: Colors.black26,
    );

    String _str =
        history.length > 0 ? history[lastCurrentLotteryNum].opencode ?? "" : "";
    var currentLastCode = _str.split(",");

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
                child: new Row(children: <Widget>[
                  // child: new Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 10.0, vertical: 5.0),
                  new Expanded(
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            (history.length > 0
                                    ? history[0].expectNo ?? ""
                                    : "") +
                                "期开奖号码",
                            style: headStyle,
                          ),
                          new Container(
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    new List.generate(_titles.length, (index) {
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
                                        currentLastCode[0] ?? "-",
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
                      ),
                    ),
                  ),

                  new Container(
                    width: 1.0,
                    height: double.infinity,
                    color: Colors.grey[200],
                    // constraints: const BoxConstraints.tightFor(),
                    //   decoration: new BoxDecoration(
                    //       border: new Border(
                    //           left: new BorderSide(
                    //               width: 1.0, color: Colors.grey[200]))),
                  ),

// new SizedBox()
                  new Expanded(
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            "${currentNum}期投注截止",
                            style: headStyle,
                          ),

                          new Container(
                            margin: EdgeInsets.all(4.0),
                            child: new Text(
                              "--:--:--",
                              style: headStyle,
                            ),
                          )
                          //new Spacer(),
                        ],
                      ),
                    ),
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
                              new LotteryHeadSliverPersistentHeaderDelegate(),
                          pinned: true,
                          floating: true,
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
                            flex: 2,
                            child: new Container(
                              color: Colors.red,
                              child: new Center(
                                child: new Text("aaaaaa"),
                              ),
                            )),
                        new Expanded(
                            child: new Container(
                          color: Colors.green,
                          child: new Center(
                            child: new IconButton(
                              onPressed: () {
                                /// turn to pay layer
                              },
                              icon: Icon(Icons.card_giftcard),
                            ),
                          ),
                        ))
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
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Semantics(
      child: new Text(
        "从万位、千位、百位,十位、个位��意意位置上至少选择1个号码，号码与相同位置的开奖号码一致。���������������������������励现金${money}元",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 150.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 0.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
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
