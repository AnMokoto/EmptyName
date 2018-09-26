import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/conf/PayIcon.dart';

class ChongzhidetailLayer extends StatefulWidget {
//  final Map<String ,dynamic> data ;
  String title;

  String en;

  String maUrl;

  String content;

  ChongzhidetailLayer({this.title, this.en, this.maUrl, this.content});

  _LotterBetRecordState createState() => new _LotterBetRecordState();
}

class _LotterBetRecordState extends State<ChongzhidetailLayer>
    with SingleTickerProviderStateMixin<ChongzhidetailLayer> {
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
          title: new Text(widget.title),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new TabBarView(
                controller: _tabController,
                children: titles.map((s) {
                  /// 待增加回退清除
                  return new LotterBetRecorderFragLayer(en: widget.en,content: widget.content,);
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
  String title;

  String en;

  String maUrl;

  String content;

  LotterBetRecorderFragLayer({this.title, this.en, this.maUrl, this.content});

  @override
  _LotterBetRecorderFragState createState() =>
      new _LotterBetRecorderFragState();
}

class _LotterBetRecorderFragState extends State<LotterBetRecorderFragLayer> {
  TextStyle small = new TextStyle(fontSize: 90.0);
 TextEditingController text = new TextEditingController();
 TextEditingController desc = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        color: Colors.grey[200],
        padding: EdgeInsets.only(bottom: 20.0),
        child: new Column(
          children: <Widget>[
            new Container(
              color: Colors.grey[100],
              child: new ListTile(
                title: new Text("收款银行： 1. 截屏保存二维码"),
              ),
            ),
            new Container(
              color: Colors.grey[100],
              child: new ListTile(
                title: new Text("收款户名： 2. 扫相册二维码付款提交"),
              ),
            ),
            new Container(
              color: Colors.grey[100],
              child: new Row(children: <Widget>[
                new Container(
                  width:100.0,
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Text("充值金额："),
                ),
                new Expanded(

                  child: new TextField(
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    controller: text,
                    decoration: new InputDecoration(
                      hintText: "充值金额最少1元",
                      border: new UnderlineInputBorder(),
                    ),
                    onChanged: (val){
                      print(val);
                      int num = int.parse(val) ;
                    },
                  ),
                ),
//                new Container(width: 200.0,)
              ],) ,
            ),
          new Container(
            color: Colors.grey[100],
            child: new Row(children: <Widget>[
              new Container(
                width:100.0,

                padding: EdgeInsets.only(left: 30.0),
                child: new Text("备注："),
              ),
              new Expanded(

                child: new TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  controller: desc,
                  decoration: new InputDecoration(
                    hintText: "建议填写您的真实姓名",
                    border: new UnderlineInputBorder(),
                  ),
                  onChanged: (val){
                    print(val);
                    int num = int.parse(val) ;
                  },
                ),
              ),
//                new Container(width: 200.0,)
            ],) ,
          ),
            new Container(
              color: Colors.grey[100],
              child: new ListTile(
                title: new Text("扫描支付："),
              ),
            ),
            new Container(
              width: 360.0,
              margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
              child: new Card(
                color: Colors.red,
                elevation: 6.0,
                child: new FlatButton(
                  onPressed: () {
                    print(text.text) ;
                    StoreProvider.of<AppState>(context).dispatch(
                      new RechargeRequestAction(
                        context,
                        {
                          'beizhu': desc.text,
                          "en": widget.en,
                          "amount": text.text,
                        },
                      ),
                    );
                  },
                  child: new Text(
                    '确定',
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ),
            new Container(
              color: Colors.grey[100],
              child: new ListTile(
                title: new Text(widget.content),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
