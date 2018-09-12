import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/conf/PayIcon.dart';
import 'Chongzhidetail.dart';
class ChongzhiqudaoLayer extends StatefulWidget {
  _LotterBetRecordState createState() => new _LotterBetRecordState();
}

class _LotterBetRecordState extends State<ChongzhiqudaoLayer>
    with SingleTickerProviderStateMixin<ChongzhiqudaoLayer> {
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
          centerTitle: true,
          backgroundColor: Colors.red,
          title: new Text("选择充值方式"),
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
        new PaywayRequestAction(context, {"pageIndex": 0, "pageSize": 100}));
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
              onTap: () {
                print("onTop");
                 Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new ChongzhidetailLayer(
                          title: "${value['title']}",
                          en: "${value['en']}",
                          maUrl: "${value['maUrl']}",
                          content: "${value['content']}",
                        )));
              },
              child: new Row(
                children: <Widget>[
                  ///左边的
                  new Container(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        PayIcon.pay("${value["en"]}", 43.0),
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
                                          child: new Text("${value["title"]}"),
                                        ),
                                        new Positioned(
                                          left: 0.0,
                                          bottom: 0.0,
                                          child: new Text(
                                            "${value["desc"]}",
                                            style: new TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black54),
                                          ),
                                        ),
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
      return state.state.paywayModel.list;
    });
  }
}
