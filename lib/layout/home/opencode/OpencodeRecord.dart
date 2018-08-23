import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'OpencodeRecordContract.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/font/Lot.dart';
class OpencodeRecordLayer extends StatefulWidget {
  _OpencodeRecordState createState() =>
      new _OpencodeRecordState(new LotterBetRecordPresenter());
}

class _OpencodeRecordState
    extends MVPState<LotterBetRecordPresenter, OpencodeRecordLayer>
    with SingleTickerProviderStateMixin<OpencodeRecordLayer>,AutomaticKeepAliveClientMixin<OpencodeRecordLayer>
    implements LotterBetRecordIVew {
  final titles = [
    "全部",
    "时时彩",
    "快三",
    "11选5",
  ];

  @override
    // TODO: implement wantKeepAlive
    bool get wantKeepAlive => true;

  @protected
  TabController _tabController;

  _OpencodeRecordState(LotterBetRecordPresenter presenter) : super(presenter) {
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
          bottom: new TabBar(
            controller: _tabController,
            tabs: titles.map((s) {
              return new Tab(
                child: new Text(
                  s,
                  style: new TextStyle(color: Theme
                      .of(context)
                      .primaryColor),
                ),
              );
            }).toList(),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
          title: new Text("开奖号码" ,),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new TabBarView(
                controller: _tabController,
                children: titles.map((s) {
                  return new OpencodeRecorderFragLayer();
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
class OpencodeRecorderFragLayer extends StatefulWidget {
  @override
  _LotterBetRecorderFragState createState() =>
      new _LotterBetRecorderFragState(new OpencodeRecordFragPresenter());
}

class _LotterBetRecorderFragState
    extends MVPState<OpencodeRecordFragPresenter, OpencodeRecorderFragLayer>
    with AutomaticKeepAliveClientMixin<OpencodeRecorderFragLayer>
    implements OpencodeRecordFragIVew {
  List<dynamic> data = new List();

  _LotterBetRecorderFragState(OpencodeRecordFragPresenter presenter)
      : super(presenter);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void requestBetRecordSuccess(List<dynamic> data) {
    assert(data != null);

    setState(() {
      this.data.addAll(data);
    });
  }

  var style = const TextStyle(
    fontSize: 15.0,
    color: Colors.black26,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter.opencodeList();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var value = data[index];
        return new Container(
          constraints: new BoxConstraints(
            maxHeight: 80.0,
          ),
          child: new InkWell(

            onTap: () {
              print("onTop");
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) =>
                  new LotteryBetRecordDetails(
                    projectEn: value["projectEn"] ?? "-",
                  )));
            },
            child: new Row(
              children: <Widget>[


                new Expanded(
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          padding: EdgeInsets.all(10.0),
                          child: new Row(
                            children: <Widget>[
                              new Text(LotConfig.getLotName("${value['gameEn']}")),
                              new Text("${value["expectNo"] ?? "-"}" + " | " +
                                  "${value['createTime'] ?? '-'}"),
                              new Text("${value["opencode"] ?? "-"}"),
                              new Icon(AppIcons.getLot("${value['gameEn']}"), size: 60.0)
                            ],
                          ),
                        ),
                      ),
                      new Divider(),
                    ],
                  ),
                ),
              ],
            )
            ,
          )
          ,
        );
      },
    );
  }
}

class LotteryBetRecordDetails extends StatefulWidget {
  final String projectEn;

  LotteryBetRecordDetails({this.projectEn}) : assert(projectEn != null);

  _LotteryBetRecordDetailsState createState() =>
      new _LotteryBetRecordDetailsState(new LotterBetRecordDetailPresenter());
}

class _LotteryBetRecordDetailsState
    extends MVPState<LotterBetRecordDetailPresenter, LotteryBetRecordDetails>
    implements LotterBetRecordDetailIVew {
  Map<String, dynamic> _map = new Map();

  _LotteryBetRecordDetailsState(LotterBetRecordDetailPresenter presenter)
      : super(presenter);

  @override
  void requestDetailsSuccess(Map<String, dynamic> map) {
    setState(() {
      this._map = map;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter.requestDetails(widget.projectEn);
  }

  @override
  Widget build(BuildContext context) {
    var style = new TextStyle(color: Colors.black87, fontSize: 13.0);
    var code;
    try {
      code = _map["tickets"] != null
          ? _map["tickets"].map((l) {
        return l["code"].toString() + "\n";
      }).toList()
          : "";
    } catch (e) {
      print("code----------");
      print(e);
      code = "";
    }

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("方案详情"),
      ),
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              constraints: new BoxConstraints(
                  minWidth: double.infinity, maxHeight: 40.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: new Stack(
                alignment: Alignment.center,
                fit: StackFit.passthrough,
                children: <Widget>[
                  new Positioned(
                    left: 0.0,
                    child: Icon(Icons.ac_unit),
                  ),
                  new Positioned(
                    right: 0.0,
                    child: new Text(
                      "${_map["awardDesc"] ?? "未中奖"}", style: new TextStyle(
                      color: Colors.red,
                    ),),

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
        ),
      ),
    );
  }
}
