import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/layout/bet/LotteryBetLayer.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/style/index.dart';

import 'dart:async';

import 'package:lowlottery/font/index.dart';

/// callback when who preclick the item.
/// [position] item count position
/// [m] anything
typedef void OnLotteryPushClick(int index, int position);

class LotteryLayer extends StatefulWidget {
  StyleManagerIMPL impl;
  String gameEn;
  PlayStyle style;
  LotteryLayer({this.impl, this.gameEn}) : assert(impl != null) {
    this.style = impl.all[0];
    this.gameEn = gameEn;
    print("..............." + gameEn);
  }
  @override
  _LotteryState createState() => new _LotteryState();
}

class _LotteryState extends State<LotteryLayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    StoreProvider.of<AppState>(context).dispatch(
        new LotteryExpectNowAction(context, {"gameEn": widget.gameEn}));
    StoreProvider.of<AppState>(context).dispatch(new LotteryExpectRecordAction(
        context, {"gameEn": widget.gameEn, "total": 1}));
  }

  Future<bool> _onPopToPreview() {
    dispatch(context, new LotteryClearAction());
    return Future.value(true);
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

    var style = widget.style;

    var _code = style.transform.code;

    var model = style.transform;

    return new WillPopScope(
      child: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new PopupMenuButton(
            child: new Text(
              style.name,
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
            onSelected: (str) {},
            // icon: Icon(Icons.arrow_drop_down),
            itemBuilder: (context) => widget.impl.all.map((f) {
                  return PopupMenuItem(
                      value: f.desc ?? "",
                      child: new OutlineButton(
                        onPressed: () {
                          setState(() {
                            widget.style = f;
                          });
                        },
                        child: new Text(f.name ?? ""),
                      ));
                }).toList(),
          ),
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

            constraints: new BoxConstraints.expand(),
            child: new Column(
              children: <Widget>[
                /// header
                new Container(
                  color: Colors.grey[100],
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
                                    children:
                                        new List.generate(style.count, (index) {
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
                                                  offset:
                                                      const Offset(2.0, 2.0)),
                                            ]),
                                        width: 22.0,
                                        height: 22.0,
                                        child: new Center(
                                          child: new Text(
                                            _str.length > 1 ? _str[index] : "-",
                                            // _str[index] ?? "-",
                                            style: const TextStyle(
                                                fontSize: 14.0,
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
                        width: .5,
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
                                "${state == null ? "" : state.expectNo ?? ""}期投注截止",
                                style: headStyle,
                              ),

                              new Container(
                                margin: EdgeInsets.all(4.0),
                                child: new Text(
                                  //data
                                  "${state == null ? "" : state.remainTime ?? ""}",

                                  style: headStyle,
                                ),
                              ),


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
                                    money: 0.0),
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
                                      position: index,
                                      style: style,
                                      callback: (index, position) {
                                        setState(() {
                                          style.toBet2System(index, position);
                                        });
                                      },
                                    ),
                                    new Divider(),
                                  ],
                                );
                              },
                              childCount: style.initialType().length,
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
//                child: new Offstage(
//                  offstage: model.zhushu <= 0,
                  child: new Container(
                    height: 55.0,
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
                                                "共${model.zhushu}注，${model.money}元",
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            new Container(
                                              constraints: new BoxConstraints(
                                                  maxWidth: 200.0),
                                              child: new Text(_code ?? "",
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
                            icon: new Icon(AppIcons.codelanzi),
                            onPressed: () {
                              /// turn to pay layer
                              StoreProvider.of<AppState>(context).dispatch(
                                  new LotterBetAdd(item: style.transform));
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => new LotteryBetLayer()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
      onWillPop: _onPopToPreview,
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
  final PlayStyle style;
  final int position;
  final OnLotteryPushClick callback;

  LotteryItem({Key key, this.style, this.position, this.callback})
      : assert(style != null),
        super(key: key);

  _LotteryItemState createState() => new _LotteryItemState();
}

class _LotteryItemState extends State<LotteryItem> {
  @override
  Widget build(BuildContext context) {
    var value = widget.style;
    int position = widget.position;
    var left = value.initialType();
    var data = value.initialArray()[widget.position];
    var height = value.height;
    return new Container(
      constraints:
          new BoxConstraints(minHeight: 80.0, minWidth: double.infinity),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// left
          new Offstage(
            offstage: left[position] == "",
            child: new Container(
              width: 50.0,
              height: 30.0,
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: new Center(
                child: new Text(
                  left[position] ?? "",
                  style: new TextStyle(
                    color: Colors.black26,
                    fontSize: 13.0,
                  ),
                  maxLines: 1,
                ),
              ),
              margin: EdgeInsets.only(right: 20.0),
            ),
          ),

          /// right
          new Expanded(
            child: new Container(
              constraints: new BoxConstraints.tightFor(height: height),
              child: new GridView.count(
                //controller: new FixedExtentScrollController(),
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                scrollDirection: Axis.vertical,
                children: new List.generate(
                  data.length,
                  (index) {
                    return new Container(
                      // color: value["able"] as bool
                      //     ? Colors.red[400]
                      //     : Colors.green[100],
                      constraints: BoxConstraints.tightForFinite(),
                      alignment: Alignment.center,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ///数字按钮
                          ///
                          new InkWell(
                              child: new Container(
                                constraints: BoxConstraints.tightForFinite(),
                                // padding: EdgeInsets.all(5.0),
                                child: new Container(
                                  constraints: new BoxConstraints(
                                      minHeight: 35.0, minWidth: 35.0),

                                  // constraints: new BoxConstraints(
                                  //     minWidth: 40.0, minHeight: 40.0),
                                  decoration: new BoxDecoration(
                                      color: data[index] != -1
                                          ? Colors.red
                                          : Colors.grey[300],
                                      shape: BoxShape.circle),
                                  child: new Center(
                                    child: new Text(
                                      "${value.forceTransform(index)}",
                                      maxLines: 1,
                                      style: new TextStyle(
                                          color: data[index] != -1
                                              ? Colors.white
                                              : Colors.red,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                widget.callback(
                                  widget.position,
                                  index,
                                );
                              }),

                          /// 预留位���
                          // new Text(
                          //   (value["sub"] as String) ?? "1",
                          // )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
