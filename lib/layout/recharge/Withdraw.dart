import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/conf/LotIcon.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/conf/PayIcon.dart';

class WithdwarLayer extends StatefulWidget {
//  final Map<String ,dynamic> data ;

  WithdwarLayer();

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
          title: new Text("提现"),
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
  LotterBetRecorderFragLayer();

  @override
  _LotterBetRecorderFragState createState() =>
      new _LotterBetRecorderFragState();
}

class _LotterBetRecorderFragState extends State<LotterBetRecorderFragLayer> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "images/oschina.png";

  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            constraints: BoxConstraints.expand(),
            color: Colors.transparent,
            child: new InkWell(
              onTap: () {
                print("TextInput.hide-----------------------");
//                SystemChannels.textInput.invokeMethod("TextInput.hide");
//                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
          ),
          new Container(
            // constraints: new BoxConstraints(maxHeight: 150.0),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.all(0.0), 
                    child: new Container(
                        color: Colors.grey[100],
                        child: new ListTile(
                          title: new Text("账户余额： 1. 截屏保存二维码"),
                        ))),
                new Padding(
                    padding: new EdgeInsets.all(0.0),
                    child: new Container(
                        color: Colors.grey[100],
                        child: new ListTile(
                          title: new Text("可提金额： 1. 截屏保存二维码"),
                        ))),
                new Padding(
                    padding: new EdgeInsets.all(0.0),
                    child: new Container(
                        color: Colors.grey[100],
                        child: new ListTile(
                          title: new Text("提现账户： 1. 截屏保存二维码"),
                        ))),
                new Padding(
                  padding: new EdgeInsets.all(0.0),
                  child: new TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    style: hintTips,
                    maxLines: 1,
                    controller: _userNameController,
                    textInputAction: TextInputAction.next,
                    decoration: new InputDecoration(
                        hintText: "账号",
                        border: new UnderlineInputBorder(),
                        labelText: '提现金额'),
                    //obscureText: true,
                  ),
                ),
                new Container(
                  width: 360.0,
                  margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
                  padding: new EdgeInsets.fromLTRB(leftRightPadding,
                      topBottomPadding, leftRightPadding, topBottomPadding),
                  child: new Card(
                    color: Colors.red,
                    elevation: 6.0,
                    child: new FlatButton(
                      onPressed: () {
                        print("the username is" + _userNameController.text);
                        StoreProvider.of<AppState>(context).dispatch(
                          new WithrawRequestAction(
                            context,
                            {
                              "amount": _userNameController.text,
                              'cardId': '123'
                            },
                          ),
                        );
                      },
                      child: new Text(
                        '确定',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),new Container(
                  color: Colors.grey[100],
                  child: new ListTile(
                    title: new Text("可提现金额=投注金额+中奖金额\n单笔提现最低10远，最高10000元\n如有疑问请联系客服："),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
