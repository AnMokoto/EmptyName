import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/layout/bet/LotteryBetLayer.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/style/index.dart';

import 'dart:async';
import 'dart:io';

import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/conf/date.dart';
import 'package:lowlottery/widget/Lottery2Layer.dart';

/// callback when who preclick the item.
/// [position] item count position
/// [index] inline index
typedef void OnLotteryPushClick(int position, int index);

@immutable
class _LotteryMenu extends StatefulWidget {
  final PlayStyle style;
  final StyleManagerIMPL impl;
  dynamic f;
  _LotteryMenu({this.impl, this.style, this.f}) : assert(style != null);

  @override
  _LotteryMenuState createState() => new _LotteryMenuState();
}

class _LotteryMenuState extends State<_LotteryMenu>
    with SingleTickerProviderStateMixin<_LotteryMenu> {
  AnimationController controller;
  Animation animation;
  _LotteryMenuState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // animation = new Tween(
    //   begin: 0,
    //   end: 1,
    // ).animate(controller);
    //controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final impl = widget.impl;
    dynamic f = widget.f;

    final title = new Text(
      style.name,
      style: new TextStyle(color: Colors.white, fontSize: 20.0),
    );

    final implTitle = new Text(
      impl.name ?? "",
      style: new TextStyle(color: Colors.blueGrey, fontSize: 20.0),
    );

    final all = impl.all;
    return new RaisedButton.icon(
      label: title,
      elevation: 0.0,
      splashColor: Colors.transparent,
      colorBrightness: Brightness.light,
      color: Colors.transparent,
      icon: new Center(
        child: new AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: Colors.white,
          semanticLabel: "aaa ",
          progress: controller,
        ),
      ),
      // icon: Icon(Icons.arrow_drop_down),
      onPressed: () {
        controller.forward();
        showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return new CupertinoActionSheet(
                  title: implTitle,
                  //message: new Text("data"),
                  actions: new List.generate(
                    all.length,
                    (index) {
                      return new CupertinoActionSheetAction(
                        onPressed: () {
                          f(all[index]);
                          Navigator.of(context).pop();
                          controller.reverse();
                        },
                        child: new Center(
                          child: new Text(all[index].name),
                        ),
                      );
                    },
                  ),
                  cancelButton: new CupertinoActionSheetAction(
                    isDefaultAction: true,
                    child: new Text(
                      "取消",
                      // style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.reverse();
                    },
                  ));
              // return new CupertinoPicker(
              //     diameterRatio: 1.0,
              //     magnification: 1.3,
              //     backgroundColor: Colors.white,
              //     looping: true,
              //     useMagnifier: true,
              //     onSelectedItemChanged: (position) {
              //       f(all[position]);
              //     },
              //     itemExtent: 25.0,
              //     children: new List.generate(all.length, (index) {
              //       return new Center(child: new Text(all[index].name));
              //     }));
            }).then((f) {
          controller.reverse();
        });
      },
    );
  }
}

class LotteryLayer extends StatefulWidget {
  StyleManagerIMPL impl;
  String gameEn;
  PlayStyle style;
  LotteryLayer({this.impl, this.gameEn}) {
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
    var style = widget.style;

    var _code = style.transform.code;

    var model = style.transform;

    return new WillPopScope(
      child: new Scaffold(
        appBar: new AppBar(
            centerTitle: true,
            title: _LotteryMenu(
                impl: widget.impl,
                style: widget.style,
                f: (f) {
                  setState(() {
                    widget.style = f;
                  });
                })),

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
                new _LotteryHeadLayer(
                  gameEn: widget.gameEn,
                  style: style,
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
                    height: Platform.isAndroid ? 50.0 : 60.0,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            constraints: new BoxConstraints.expand(),
                            color: Colors.red,
                            child: new Padding(
                              padding: EdgeInsets.all(5.0),
                              child: new InkWell(
                                onTap: () {
                                  if (style.isValid()) {
                                    final trans =
                                        PlayModelItem.copy(style.transform);
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(
                                            new LotterBetAdd(item: trans));
                                    setState(() {
                                      widget.style.playReset();
                                    });
                                  }
                                },
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.add,
                                      size: 40.0,
                                      color: Colors.white,
                                    ),
                                    new Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      constraints:
                                          new BoxConstraints.tightForFinite(),
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new SafeArea(
                                            bottom: false,
                                            child: new Text(
                                              "共${model.zhushu}注，${model.money}元",
                                              style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            constraints: new BoxConstraints
                                                .tightForFinite(width: 180.0),
                                            child: new Text(_code ?? "",
                                                overflow: TextOverflow.ellipsis,
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
                              ),
                            ),
                          ),
                        ),
                        new ConstrainedBox(
                          constraints:
                              new BoxConstraints(minHeight: double.infinity),
                          child: new Stack(
                              fit: StackFit.passthrough,
                              children: <Widget>[
                                new RaisedButton.icon(
                                  textColor: Colors.white,
                                  elevation: 0.0,
                                  // highlightColor: Colors.transparent,
                                  // splashColor: Colors.transparent,
                                  color: Colors.black87,
                                  label: new Text("号码篮"),
                                  icon: new Icon(AppIcons.codelanzi),
                                  onPressed: () {
                                    /// turn to pay layer
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new LotteryBetLayer(
                                                  style: style,
                                                )));
                                  },
                                ),
                                new Positioned(
                                  left: 20.0,
                                  top: 5.0,
                                  child: new StoreConnector<AppState, int>(
                                      builder: (context, state) {
                                    return Offstage(
                                      offstage: state <= 0,
                                      child: new Container(
                                        constraints: new BoxConstraints(
                                          minWidth: 10.0,
                                          minHeight: 10.0,
                                          maxWidth: 20.0,
                                          maxHeight: 20.0,
                                        ),
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: new Center(
                                          child: new Text("$state",
                                              style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.0,
                                              )),
                                        ),
                                      ),
                                    );
                                  }, converter: (state) {
                                    var content = state.state.betModel.content;
                                    return content == null ? 0 : content.length;
                                  }),
                                ),
                              ]),
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

/// 顶部指示器
@immutable
class _LotteryHeadLayer extends StatefulWidget {
  final String gameEn;
  final PlayStyle style;
  _LotteryHeadLayer({this.gameEn, this.style})
      : assert(gameEn != null && style != null);
  _LotteryHeadState createState() => new _LotteryHeadState();
}

class _LotteryHeadState extends State<_LotteryHeadLayer>
    with WidgetsBindingObserver {
  //Timer _timer;
  bool isAlive, isShowDialog = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      _requestNewQState();
    }
  }

  void _requestNewQState() {
    StoreProvider.of<AppState>(context).dispatch(
        new LotteryExpectNowAction(context, {"gameEn": widget.gameEn}));
    StoreProvider.of<AppState>(context).dispatch(new LotteryExpectRecordAction(
        context, {"gameEn": widget.gameEn, "total": 1}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestNewQState();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    isAlive = true;
    _startTimer();
  }

  Future _startTimer() async {
    if (!isAlive) return Future.value(false);
    return Future.delayed(Duration(seconds: 1), () {
      if (isAlive) {
        try {
          _startTimer();

          ///发送更改时间
          dispatch(context, LotteryRefreshDeadLineAction());
          //setState(() {});
        } catch (e) {}
      }
    });
  }

  @override
  void dispose() {
    isAlive = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var headStyle = const TextStyle(
      fontSize: 12.0,
      color: Colors.black26,
    );
    var style = widget.style;
    return new Container(
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
                            ? (state.history.isNotEmpty
                                ? state.history[0].expectNo ?? ""
                                : "")
                            : "") +
                        "期开奖号码",
                    style: headStyle,
                  ),
                  new Container(
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: new List.generate(style.count, (index) {
                          var _str = (state.history != null
                                  ? (state.history.isNotEmpty
                                      ? state.history[0].opencode as String ??
                                          ""
                                      : "")
                                  : "")
                              .split(",");
                          return new Container(
                            decoration: new BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                      color: Colors.black26,
                                      offset: const Offset(2.0, 2.0)),
                                ]),
                            width: 22.0,
                            height: 22.0,
                            child: new Center(
                              child: new Text(
                                _str.length > 1 ? _str[index] : "-",
                                // _str[index] ?? "-",
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.white),
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

        new Container(
            margin: EdgeInsets.only(left: 5.0),
            padding: EdgeInsets.all(3.0),
            child: new StoreConnector<AppState, LotteryState>(
              builder: (c, state) {
                var store = state.lottery;
                var time =
                    "00:00:00"; //"${store == null ? "" : store.remainTime ?? ""}"

                if (store != null) {
                  final deadLine = store.remainTime as int;
                  // if (_timer != null) {
                  //   if (_timer.isActive) {
                  //     _timer.cancel();
                  //   }
                  //   _timer = null;
                  // }

                  if (deadLine <= 0) {
                    if (!isShowDialog) {
                      isShowDialog = true;
                      Future.delayed(Duration(milliseconds: 100), () {
                        showPopDialog(context, state.lottery);
                      });
                    }
                    time = "投注截止";
                  } else {
                    // if (!isAlive) {
                    //   isAlive = true;
                    //   _startTimer();
                    // }
                    time = DateHelper.invoke(deadLine);
                  }
                }

                return new Column(
                  children: <Widget>[
                    new Text(
                      "${store == null ? "" : store.expectNo ?? ""}期投注截止",
                      style: headStyle,
                    ),

                    new Container(
                      margin: EdgeInsets.all(4.0),
                      child: new Text(
                        //data

                        time,

                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black26,
                        ),
                      ),
                    ),

                    //new Spacer(),
                  ],
                );
              },
              converter: (state) {
                return state.state.lottery;
              },
            )),
      ]),
    );
  }

  void showPopDialog(BuildContext context, LotteryModel model) {
    final expectNo = model.expectNo;
    final dialogBtnStyle =
        new TextStyle(color: Colors.lightBlue, fontSize: 12.0);

    final dialogTextStyle = new TextStyle(
      color: Colors.black87,
      fontSize: 13.0,
    );
    showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (context) {
          _requestNewQState();
          return new CupertinoAlertDialog(
            title: new Text(
              "本期结束",
              style: dialogTextStyle,
            ),
            content: new Text(
              "$expectNo 期已结束",
              style: dialogTextStyle,
            ),
            actions: <Widget>[
              new CupertinoDialogAction(
                child: new Text(
                  "确定",
                  style: dialogBtnStyle,
                ),
                isDefaultAction: true,
                onPressed: () {
                  //isAlive = true;
                  //_startTimer();
                  Navigator.of(context).pop();
                  ////启动重新开始的时间计时器
                  _requestNewQState();
                  isShowDialog = false;
                },
              )
            ],
          );
        });
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
    return new Lottery2Layer(
      billboard: value.billboard(position),
      style: value.layerStyle,
      child: value.generate(position, widget.callback),
    );
    // return new Container(
    //   constraints:
    //       new BoxConstraints(minHeight: 80.0, minWidth: double.infinity),
    //   child: new Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       /// left
    //       new Offstage(
    //         offstage: left[position] == "",
    //         child: new Container(
    //           width: 50.0,
    //           height: 30.0,
    //           decoration: new BoxDecoration(
    //             color: Colors.grey[300],
    //             shape: BoxShape.rectangle,
    //             borderRadius: BorderRadius.circular(4.0),
    //           ),
    //           child: new Center(
    //             child: new Text(
    //               left[position] ?? "",
    //               style: new TextStyle(
    //                 color: Colors.black26,
    //                 fontSize: 13.0,
    //               ),
    //               maxLines: 1,
    //             ),
    //           ),
    //           margin: EdgeInsets.only(right: 20.0),
    //         ),
    //       ),

    //       /// right
    //       new Expanded(
    //         child: new Container(
    //           constraints: new BoxConstraints.tightFor(height: height),
    //           child: new GridView.count(
    //             //controller: new FixedExtentScrollController(),
    //             physics: new NeverScrollableScrollPhysics(),
    //             crossAxisCount: 5,
    //             childAspectRatio: 1.0,
    //             scrollDirection: Axis.vertical,
    //             children: new List.generate(
    //               data.length,
    //               (index) {
    //                 return new Container(
    //                   // color: value["able"] as bool
    //                   //     ? Colors.red[400]
    //                   //     : Colors.green[100],
    //                   constraints: BoxConstraints.tightForFinite(),
    //                   alignment: Alignment.center,
    //                   child: new Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       ///数字按钮
    //                       ///
    //                       new InkWell(
    //                           child: new Container(
    //                             constraints: BoxConstraints.tightForFinite(),
    //                             // padding: EdgeInsets.all(5.0),
    //                             child: new Container(
    //                               constraints: new BoxConstraints(
    //                                   minHeight: 35.0, minWidth: 35.0),

    //                               // constraints: new BoxConstraints(
    //                               //     minWidth: 40.0, minHeight: 40.0),
    //                               decoration: new BoxDecoration(
    //                                   color: data[index] != -1
    //                                       ? Colors.red
    //                                       : Colors.grey[300],
    //                                   shape: BoxShape.circle),
    //                               child: new Center(
    //                                 child: new Text(
    //                                   "${value.forceTransform(index)}",
    //                                   maxLines: 1,
    //                                   style: new TextStyle(
    //                                       color: data[index] != -1
    //                                           ? Colors.white
    //                                           : Colors.red,
    //                                       fontSize: 17.0),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             widget.callback(
    //                               widget.position,
    //                               index,
    //                             );
    //                           }),

    //                       /// 预留位���
    //                       // new Text(
    //                       //   (value["sub"] as String) ?? "1",
    //                       // )
    //                     ],
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
