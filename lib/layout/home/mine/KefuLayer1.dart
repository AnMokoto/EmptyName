import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/store/AppStore.dart';
import 'CardLayer.dart';
import 'AlipayLayer.dart';
import 'ModifyPwdLayer.dart';
import 'package:lowlottery/layout/login/LoginLayer.dart';
import 'package:lowlottery/store/sp.dart';

class KefuLayer extends StatefulWidget {
  KefuLayer();

  _OpencodeRecordState createState() => new _OpencodeRecordState();
}

class _OpencodeRecordState extends State<KefuLayer>
    with SingleTickerProviderStateMixin<KefuLayer> {
  final titles = [
    "全部",
  ];
  @protected
  TabController _tabController;

  _OpencodeRecordState();

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
  OpencodeRecorderFragLayer();

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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: new AlwaysScrollableScrollPhysics(),
      controller: new ScrollController(),
      child: new Container(
        color: Colors.grey[100],
        padding: EdgeInsets.only(bottom: 20.0),
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.grey[100],
              child: new Text("QQ客服：90887877"),
            ),
            new Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.grey[100],
              child: new Text("微信客服：90887877"),
            ),

          ],
        ),
      ),
    );
  }
}
