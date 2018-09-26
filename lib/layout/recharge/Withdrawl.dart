import 'package:flutter/material.dart';
import 'package:lowlottery/store/appStore.dart';

class WithdwarLayer extends StatefulWidget {
//  final Map<String ,dynamic> data ;

  double totalMoney;

  int ketixian;

  WithdwarLayer({this.ketixian, this.totalMoney});

  _LotterBetRecordState createState() => new _LotterBetRecordState();
}

class _LotterBetRecordState extends State<WithdwarLayer>
    with SingleTickerProviderStateMixin<WithdwarLayer> {
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
          title: new Text('提现'),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new TabBarView(
                controller: _tabController,
                children: titles.map((s) {
                  /// 待增加回退清除
                  return new LotterBetRecorderFragLayer(
                    ketixian: widget.ketixian,
                    totalMoney: widget.totalMoney,
                  );
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
  double totalMoney;

  int ketixian;

  LotterBetRecorderFragLayer({this.ketixian, this.totalMoney});

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
              child: new ListTile(
                title: new Text("账户余额： ${widget.totalMoney}"),
              ),
            ),
            new Container(
              child: new ListTile(
                title: new Text("可提金额： ${widget.ketixian}"),
              ),
            ),
            new Container(
              child: new ListTile(
                title: new Text("提现账户： 66666"),
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 100.0,
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Text("提现金额："),
                  ),
                  new Expanded(
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      controller: text,
                      decoration: new InputDecoration(
                        hintText: "提现金额最少10元",
                        border: new UnderlineInputBorder(),
                      ),
                      onChanged: (val) {
                        print(val);
                        int num = int.parse(val);
                      },
                    ),
                  ),
//                new Container(width: 200.0,)
                ],
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
                    print(text.text);
                    StoreProvider.of<AppState>(context).dispatch(
                      new WithrawRequestAction(
                        context,
                        {"amount": text.text, 'cardId': '123'},
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
              child: new ListTile(
                title:
                    new Text("可提现金额=投注金额+中奖金额\n单笔提现最低10元，最高10000元\n如有疑问请联系客服"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
