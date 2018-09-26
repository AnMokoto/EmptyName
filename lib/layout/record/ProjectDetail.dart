import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';
import 'RedUtil.dart';
import 'package:lowlottery/layout/lottery/LotteryLayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/widget/fixbox/FixBoxWidget.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:lowlottery/layout/lottery/LotteryLayer.dart';
import 'package:lowlottery/style/index.dart' show StyleSplit;
import 'package:lowlottery/store/appStore.dart';
import 'Tickets.dart';
import 'package:lowlottery/layout/pops/ToastUtil.dart';
import 'package:flutter/services.dart';

/**
 * 方案详情
 */
class ProjectDetail extends StatefulWidget {
  final String projectEn;

  ProjectDetail({this.projectEn});

  _LotteryBetRecordDetailsState createState() =>
      new _LotteryBetRecordDetailsState();
}

class _LotteryBetRecordDetailsState extends State<ProjectDetail> {
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
              if (_map == null) _map = {};
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
                          child: new Row(
                            children: <Widget>[
                              // Image.network(""),
                              new Container(
                                child: LotIcon.logo(
                                    "${_map["gameEn"] ?? ''}", 33.0),
                              ),
                              new Container(
                                margin: new EdgeInsets.all(15.0),
                                child: new Text(LotConfig.getLotName(
                                    "${_map["gameEn"] ?? "-"}")),
                              )

//                        new Text(LotConfig.getLotName("${_map["gameEn"]??"-"}"))
                            ],
                          ),
                        ),
                        new Positioned(
                            right: 0.0,
                            child: RedUtil.buildText(
                                "${_map['awardDesc']}", "${_map['isRed']}")),
                      ],
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
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
                          "投注信息：${_map["zhushu"] ?? ""}注  ${_map["beishu"] ?? ""}倍",
                          style: style,
                        ),
                        new Text(
                          "开奖号码：${_map["opencode"] ?? ""}",
                          style: style,
                        ),
                        new Text(
                          "方案内容：",
                          style: style,
                        ),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: Tickets.build(_map["tickets"]),
                  ),
                  new Container(
                    padding: EdgeInsets.all(10.0),
                    height: 60.0,
                    child: new InkWell(
                      onTap: () {
                        print('${_map["projectEn"]}');
                        ToastUtil.show('方案号码已复制');
                        Clipboard.setData(
                            new ClipboardData(text: '${_map["projectEn"]}'));
                      },
                      child: new Row(
                        children: <Widget>[
                          new Text("方案编号：${_map["projectEn"] ?? ""}"),
                          new Text('    点击复制'),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    width: 360.0,
                    margin: new EdgeInsets.fromLTRB(40.0, 1.0, 40.0, 10.0),
                    child: new Card(
                      color: Colors.red,
                      elevation: 6.0,
                      child: new FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new LotteryLayer(
                                  impl: StyleSplit.of(
                                      "${_map["gameEn"] ?? ""}", []),
                                  gameEn: "${_map["gameEn"] ?? ""}",
                                ),
                          ));
                        },
                        child: new Text(
                          '继续投注',
                          style: new TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
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
