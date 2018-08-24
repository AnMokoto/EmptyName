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
          backgroundColor: Colors.white,
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
             /* Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) =>
                  new LotOpencodelistDetails(
                    gameEn: "${value["gameEn"]}",
                  )));*/
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
//                              new Icon(AppIcons.getLot("${value['gameEn']}"), size: 60.0)
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