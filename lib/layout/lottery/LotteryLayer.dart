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
import 'package:lowlottery/conf/Lot.dart';
import 'LotPlayDesc.dart';
import 'package:lowlottery/layout/home/opencode/Opencode.dart';
import 'Header.dart';

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

    // style.multiple = impl.playEns().map((playEn)=> impl.playStyle(playEn)).where((play)=>play!=null).toList()

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
  var _userNameController = new TextEditingController();

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

  void _handleSubmitted(String text) {
    _userNameController.clear();
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
        backgroundColor: Colors.white,
        body: new Container(
            constraints: new BoxConstraints.expand(),
            child: new Column(
              children: <Widget>[
                /// header
                new LotteryHeadLayer(
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
                                    playEn: style.type),
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
                                    new StoreConnector<AppState, LotplayModel>(
                                      builder: (context, state) {
                                        final map = state.list.firstWhere(
                                            (w) => w['playEn'] == style.type);
                                        if (map != null &&
                                            map['odds'] != null) {
                                          style.multiple = map['odds'];
                                        }

                                        return new LotteryItem(
                                          position: index,
                                          style: style,
                                          callback: (index, position) {
                                            setState(() {
                                              style.toBet2System(
                                                  index, position);
                                            });
                                          },
                                        );
                                      },
                                      converter: (state) {
                                        return state.state.lotplayModel;
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

                /// 倍数
                new Container(
                    child: Row(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        AppIcons.jian,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        style.transform.beishu--;

                        print('less ${style.transform.beishu}');
                      },
                    ),
                    new IconButton(
                      icon: new Icon(
                        AppIcons.add,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        style.transform.beishu++;
                        print('add${style.transform.beishu}');
                      },
                    ),
                    new Text(
                      "倍",
                      style: new TextStyle(color: Colors.grey),
                    ),
                  ],
                )),

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
                                    new StoreConnector<AppState, PlayModel>(
                                        builder: (context, state) {
                                      return new Container(
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
                                                "共${style.transform.zhushu}注${style.transform.beishu}倍，${model.money}元",
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
                                      );
                                    }, converter: (state) {
                                      var content =
                                          state.state.betModel.content;
                                      print(state.state.betModel.money);
                                      return state.state.betModel;
                                    }),
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
  }
}
