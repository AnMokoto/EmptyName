import 'package:flutter/material.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/store/appStore.dart';
import 'dart:async';

class OpencodeRecordLayer extends StatefulWidget {
  _OpencodeRecordState createState() => new _OpencodeRecordState();
}

class _OpencodeRecordState extends State<OpencodeRecordLayer>
    with SingleTickerProviderStateMixin<OpencodeRecordLayer> {
  final titles = [
    "全部",
    "时时彩",
    "快三",
    "11选5",
  ];

  @protected
  TabController _tabController;

  _OpencodeRecordState() {
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
                  style: new TextStyle(color: Colors.redAccent),
                ),
              );
            }).toList(),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          title: new Text(
            "开奖号码",style: new TextStyle(color: Colors.red),
          ),
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
      new _LotterBetRecorderFragState();
}

class _LotterBetRecorderFragState extends State<OpencodeRecorderFragLayer> {
  var style = const TextStyle(
    fontSize: 15.0,
    color: Colors.black26,
  );

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dispatch(context,
        new SecondRequestAction(context, {"pageIndex": 0, "pageSize": 100}));
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<dynamic>>(
      builder: (context, state) {
        return new ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            var value = state[index];
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
                                  new Text(LotConfig.getLotName(
                                      "${value['gameEn']}")),
                                  new Text("${value["expectNo"] ?? "-"}" +
                                      " | " +
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
                ),
              ),
            );
          },
        );
      },
      converter: (state) {
        return state.state.homeModel.second;
      },
    );
  }
}
