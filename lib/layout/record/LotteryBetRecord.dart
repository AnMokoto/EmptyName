import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';
import 'RedUtil.dart';
import 'ProjectDetail.dart';
import 'Nodata.dart';

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
      Container nodata = Nodata.nodata(state);
      if (nodata != null) return nodata;
      return new ListView.builder(
        itemCount: state == null ? 0 : state.length,
        itemBuilder: (context, index) {
          var value = state[index];
          return new Container(
            constraints: new BoxConstraints(
              maxHeight: 80.0,
            ),
            child: new InkWell(
              onTap: () {
                print("onTop");
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new ProjectDetail(
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
                            LotConfig.getLotShortName(
                                "${value["gameEn"] ?? "-"}"),
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
                                            child: RedUtil.buildText(
                                                "${value['statusDesc']}",
                                                "${value['isRed']}")),
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
