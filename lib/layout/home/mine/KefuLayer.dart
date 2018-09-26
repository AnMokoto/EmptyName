import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/layout/record/Nodata.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:flutter/services.dart';
import 'package:lowlottery/layout/pops/ToastUtil.dart';
class KefuLayer extends StatefulWidget {
  _OpencodeRecordState createState() => new _OpencodeRecordState();
}

class _OpencodeRecordState extends State<KefuLayer>
    with SingleTickerProviderStateMixin<KefuLayer> {
  final titles = [
    "全部",
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
          centerTitle: true,
          backgroundColor: Colors.red,
          title: new Text(
            "客服中心",
            style: new TextStyle(color: Colors.white),
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
        new KefuRequestAction(context, {"pageIndex": 0, "pageSize": 100}));
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<dynamic>>(
      builder: (context, state) {
        Container nodata = Nodata.nodata(state);
        if (nodata != null) return nodata;
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
                  print('${value["desc"]}');
                  ToastUtil.show('内容： ${value['desc']} 已复制');
                  Clipboard.setData(
                      new ClipboardData(text: '${value["desc"]}'));
                },
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: new Row(
                                children: <Widget>[
                                  new Text(
                                    "${value['name']}：  ",
                                    style: new TextStyle(fontSize: 14.0),
                                  ),
                                  new Text("  ${value["desc"]}",
                                      style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black87)),

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
        return state.state.kefuModel.list;
      },
    );
  }
}
