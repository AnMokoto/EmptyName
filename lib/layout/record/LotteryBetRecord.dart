import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';

class LotterBetRecordLayer extends StatefulWidget {
  _LotterBetRecordState createState() => new _LotterBetRecordState();
}

class _LotterBetRecordState extends State<LotterBetRecordLayer>
    with SingleTickerProviderStateMixin<LotterBetRecordLayer> {
  final titles = [
    "全部",

  ];

  @protected
  TabController _tabController;

  _LotterBetRecordState() {
    this._tabController =
        new TabController(length: titles.length, vsync: this, initialIndex: 0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: titles.length,
      initialIndex: 0,
      child: new Scaffold(
        appBar: new AppBar(
          /*bottom: new TabBar(
            controller: _tabController,
            tabs: titles.map((s) {
              return new Tab(
                child: new Text(
                  s,
                  style: new TextStyle(color: Theme.of(context).primaryColor),
                ),
              );
            }).toList(),
          ),*/
          centerTitle: true,
          backgroundColor: Colors.red,
          title: new Text("投注记录"),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new TabBarView(
                controller: _tabController,
                children: titles.map((s) {
                  /// 待增加回退清除
                  return new LotterBetRecorderFragLayer();
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// index Fragment
class LotterBetRecorderFragLayer extends StatefulWidget {
  @override
  _LotterBetRecorderFragState createState() =>
      new _LotterBetRecorderFragState();
}

class _LotterBetRecorderFragState extends State<LotterBetRecorderFragLayer> {
  TextStyle small = new TextStyle(fontSize: 90.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dispatch(context,
        new LotteryRecordAction(context, {"pageIndex": 0, "pageSize": 100}));
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<dynamic>>(
        builder: (context, state) {
      return new ListView.builder(
        itemCount: state == null ? 0 : state.length,
        itemBuilder: (context, index) {
          var value = state[index];
          return new Container(
            constraints: new BoxConstraints(
              maxHeight: 80.0,
            ),
            child: new InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return new AlertDialog(
                      title: new Text("data"),
                    ).build(context);
                  },
                );
              },
              onTap: () {
                print("onTop");
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new LotteryBetRecordDetails(
                          projectEn: value["projectEn"] ?? "-",
                        )));
              },
              child: new Row(
                children: <Widget>[
                  ///左边的
                  new Container(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        // Image.network(""),
//                      new Icon(AppIcons.getLot("${value["gameEn"]}"),size: 33.0,),
                        LotIcon.logo("${value["gameEn"]}", 33.0),
                        new Text(
                            LotConfig.getLotShortName("${value["gameEn"] ?? "-"}"),
                            style: new TextStyle(
                                fontSize: 11.0, color: Colors.black54))
                      ],
                    ),
                  ),

                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            padding: EdgeInsets.all(10.0),
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    margin: EdgeInsets.only(right: 20.0),
                                    child: new Stack(
                                      children: <Widget>[
                                        new Positioned(
                                          left: 0.0,
                                          top: 0.0,
                                          child: new Text(
                                            "${value["statusDesc"] ?? "-"}",
                                            style: new TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        new Positioned(
                                          right: 0.0,
                                          top: 0.0,
                                          child: new Text("自购"),
                                        ),
                                        new Positioned(
                                          right: 0.0,
                                          bottom: 0.0,
                                          child: new Text(
                                            "投注${value["money"] ?? "-"}元",
                                            style: new TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        new Positioned(
                                          left: 0.0,
                                          bottom: 0.0,
                                          child: new Text(
                                            "${value["createTimeStr"] ?? "-"}",
                                            style: new TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black54),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                new Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                        new Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }, converter: (state) {
      return state.state.record.data;
    });
  }
}

class LotteryBetRecordDetails extends StatefulWidget {
  final String projectEn;

  LotteryBetRecordDetails({this.projectEn}) : assert(projectEn != null);

  _LotteryBetRecordDetailsState createState() =>
      new _LotteryBetRecordDetailsState();
}

class _LotteryBetRecordDetailsState extends State<LotteryBetRecordDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dispatch(
        context,
        new LotteryRecordDetailAction(
            context, {"projectEn": widget.projectEn ?? ""}));
  }

  @override
  Widget build(BuildContext context) {
    var style = new TextStyle(color: Colors.black87, fontSize: 13.0);

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("方案详情"),
      ),
      body: new Container(
          constraints: new BoxConstraints.expand(),
          child: new StoreConnector<AppState, Map<String, dynamic>>(
            builder: (context, _map) {
              var code;
              try {
                code = _map["tickets"] != null
                    ? _map["tickets"].map((l) {
                        return l["code"].toString() + "\n";
                      }).toList().toString().replaceAll("[", "").replaceAll("]", "")
                    : "";
              } catch (e) {
                print("code----------");
                print(e);
                code = "";
              }
              return new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    constraints: new BoxConstraints(
                        minWidth: double.infinity, maxHeight: 55.0),
                    padding: EdgeInsets.all(10.0),
                    color: Colors.grey[200],
                    child: new Stack(
                      alignment: Alignment.center,
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        new Positioned(
                          left: 0.0,
                          child: new Column(
                            children: <Widget>[
                              // Image.network(""),
                              LotIcon.logo("${_map["gameEn"]}", 33.0),
//                        new Text(LotConfig.getLotName("${_map["gameEn"]??"-"}"))
                            ],
                          ),
                        ),
                        new Positioned(
                          right: 0.0,
                          child: new Text(
                            "${_map["awardDesc"] ?? "未中奖"}",
                            style: new TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: new Border.all(color: Colors.white30),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    padding: EdgeInsets.all(10.0),
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text("彩        种：" +
                            LotConfig.getLotName("${_map["gameEn"] ?? "-"}")),
                        new Text(
                          "期        号：第${_map["expectNo"] ?? ""}期",
                          style: style,
                        ),
                        new Text(
                          "投注金额：${_map["money"] ?? ""}元",
                          style: style,
                        ),
                        new Text(
                          "投注玩法：${_map["playDesc"] ?? ""}",
                          style: style,
                        ),
                        new Text(
                          "投注号码：${code}",
                          style: style,
                        ),
                        new Text(
                          "投注信息：${_map["zhushu"] ?? ""}注  ${_map["beishu"] ?? ""}倍",
                          style: style,
                        ),
                        new Text(
                          "开奖号码：${_map["opencode"] ?? ""}",
                          style: style,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(10.0),
                    child: new Text("投注时间：${_map["createTime"] ?? ""}"),
                  ),
                  new Container(
                    padding: EdgeInsets.all(10.0),
                    child: new Text("方案编号：${_map["projectEn"] ?? ""}"),
                  )
                ],
              );
            },
            converter: (state) {
              return state.state.record.detail;
            },
          )),
    );
  }
}
