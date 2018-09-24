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
import 'package:lowlottery/layout/home/opencode/LotOpencodeRecord.dart';

/// callback when who preclick the item.
/// [position] item count position
/// [index] inline index
typedef void OnLotteryPushClick(int position, int index);

/// 顶部指示器
@immutable
class LotteryHeadLayer extends StatefulWidget {
  final String gameEn;
  final PlayStyle style;

  LotteryHeadLayer({this.gameEn, this.style})
      : assert(gameEn != null && style != null);

  _LotteryHeadState createState() => new _LotteryHeadState();
}

class _LotteryHeadState extends State<LotteryHeadLayer>
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
//          dispatch(context, LotteryRefreshDeadLineAction());
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
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: new Row(children: <Widget>[
        // child: new Padding(
        //     padding: EdgeInsets.symmetric(
        //         horizontal: 10.0, vertical: 5.0),
        new Container(
//          margin: EdgeInsets.only(right: 5.0),
          padding: EdgeInsets.all(3.0),
          child: new Container(
              child: new InkWell(
            onTap: () {
              print('to opencode list');
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new LotOpencodeRecordLayer(
                        gameEn: widget.gameEn,
                      )));
            },
            child: new StoreConnector<AppState, List<Lottery>>(
              builder: (context, history) {
                return new Column(
                  children: <Widget>[
                    new Text(
                      (history != null
                              ? (history.isNotEmpty
                                  ? history[0].expectNo ?? ""
                                  : "")
                              : "") +
                          "期开奖号码",
                      style: headStyle,
                    ),
                    new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: new List.generate(
                          style.count,
                          (index) {
                            var _str = (history != null
                                    ? (history.isNotEmpty
                                        ? history[0].opencode as String ?? ""
                                        : "")
                                    : "")
                                .split(",");

                            var gameEn = widget.gameEn;
                            return new StoreConnector<AppState, List<dynamic>>(
                              builder: (context, sxList) {
                                return OpenCode.opencode(
                                    gameEn, _str, index, sxList);
                              },
                              converter: (state) {
                                return state.state.homeModel.sxConfig;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              converter: (state) {
                return state.state.lottery.history;
              },
            ),
          )),
        ),

// new SizedBox()

        new Expanded(
//            margin: EdgeInsets.only(left: 5.0),
//            padding: EdgeInsets.all(3.0),
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
                margin: EdgeInsets.only(right: 5.0),
                child: new StoreConnector<AppState, LotteryModel>(
                  builder: (c, state) {
                    var time =
                        "00:00:00"; //"${store == null ? "" : store.remainTime ?? ""}"

                    if (state != null) {
                      final deadLine = state.remainTime as int;
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
                            showPopDialog(context, state);
                          });
                        }
                        time = "";
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
                          "${state == null ? "" : state.expectNo ?? ""}期",
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
                    return state.state.lottery.lottery;
                  },
                )),
          ],
        )),
      ]),
    );
  }

  void showPopDialog(BuildContext context, LotteryModel model) {
    final expectNo = model.expectNo;
    final dialogBtnStyle = new TextStyle(color: Colors.grey, fontSize: 12.0);

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
              "${LotConfig.getLotName(model.gameEn)}",
              style: dialogTextStyle,
            ),
            content: new Text(
              "$expectNo 期已截止投注",
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
