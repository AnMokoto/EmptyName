import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/conf/Pk10Color.dart';
import 'Opencode.dart';
import 'package:lowlottery/layout/record/Nodata.dart';

class LotOpencodeRecordLayer extends StatefulWidget {
  final String gameEn;

  LotOpencodeRecordLayer({this.gameEn}) : assert(gameEn != null);

  _OpencodeRecordState createState() => new _OpencodeRecordState();
}

class _OpencodeRecordState extends State<LotOpencodeRecordLayer>
    with SingleTickerProviderStateMixin<LotOpencodeRecordLayer> {
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
            LotConfig.getLotName(widget.gameEn),
            style: new TextStyle(color: Colors.white),
          ),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new TabBarView(
                controller: _tabController,
                children: titles.map((s) {
                  return new OpencodeRecorderFragLayer(gameEn: widget.gameEn);
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
  final String gameEn;

  OpencodeRecorderFragLayer({this.gameEn}) : assert(gameEn != null);

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
    dispatch(
        context,
        new OpencodeRequestAction(context, {
          "total": 100,
          "gameEn": widget.gameEn,
          "pageIndex": 0,
          "pageSize": 100
        }));
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OpencodeModel>(
      builder: (context, appstate) {
        List<dynamic> state = appstate.list;

        Container nodata = Nodata.nodata(state);
        if (nodata != null) return nodata;
        return new ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            var value = state[index];
            return new Container(
              constraints: new BoxConstraints(
                maxHeight:
                    value['gameEn'].toString().contains("lhc") ? 120.0 : 80.0,
              ),
//              margin: EdgeInsets.all(10.0),
              child: new InkWell(
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: new Row(
                                children: <Widget>[
                                  new Text(
                                    LotConfig.getLotName("${value['gameEn']}"),
                                    style: new TextStyle(fontSize: 14.0),
                                  ),
                                  new Text("  第 ${value["expectNo"] ?? "-"}期",
                                      style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black87)),
                                  new Text("         ${value["desc"]}",
                                      style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black87)),
                                ],
                              ),
                            ),
                          ),
                          new Expanded(
                              child: new Container(
//                              margin: EdgeInsets.all(10.0),
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: new List.generate(
                                    "${value['opencode']}".split(",").length,
                                    (index) {
                                  var _str =
                                      "${value["opencode"] ?? "-"}".split(",");
                                  var gameEn = '${value["gameEn"]}';
                                  return new StoreConnector<AppState,
                                      List<dynamic>>(
                                    builder: (context, sxList) {
                                      return OpenCode.opencode(
                                          gameEn, _str, index, sxList);
                                    },
                                    converter: (state) {
                                      return state.state.homeModel.sxConfig;
                                    },
                                  );
                                })),
                          )),
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
        return state.state.opencodeModel;
      },
    );
  }
}
