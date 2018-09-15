import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/store/AppStore.dart';
import 'package:lowlottery/store/appStore.dart';

class AnquanLayer extends StatefulWidget {
  AnquanLayer();

  _OpencodeRecordState createState() => new _OpencodeRecordState();
}

class _OpencodeRecordState extends State<AnquanLayer>
    with SingleTickerProviderStateMixin<AnquanLayer> {
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
            "安全中心",
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
        color: Colors.grey[200],
        padding: EdgeInsets.only(bottom: 20.0),
        child: new Column(
          children: <Widget>[
            new Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                new AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Image.asset(
                    "assets/images/avatar.png",
                    fit: BoxFit.cover,
                  ),
                ), //

                new Container(
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(top: 70.0),
                  constraints: new BoxConstraints(minWidth: double.infinity),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      /// 头像区域
                      new StoreConnector<AppState, UserInfo>(
                          builder: (context, state) {
                        return new Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                "${state.nickName ?? state.username ?? ""}",
                                style: new TextStyle(
                                    fontSize: 15.0, color: Colors.white70),
                              ),
                            ],
                          ),
                        );
                      }, converter: (state) {
                        return state.state.userModel.mUserInfo;
                      }),
                    ],
                  ),
                ),
              ],
            ),
            new Container(
              color: Colors.grey[100],
              child: new ListTile(
                /*onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new LotterBetRecordLayer(),
                  ));
                },*/
                leading: Icon(AppIcons.pwd, color: Colors.grey),
                title: new Text("修改登录密码"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                /*onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new AccountRecordLayer(),
                  ));
                },*/
                leading: Icon(AppIcons.pwd, color: Colors.grey),
                title: new Text("设置安全密码"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                /*onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new WithdrawRecordLayer(),
                  ));
                },*/
                leading: Icon(AppIcons.phone, color: Colors.grey),
                title: new Text("绑定手机"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                /*onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new MessageLayer(),
                  ));
                },*/
                leading: Icon(AppIcons.chongzhi, color: Colors.grey),
                title: new Text("银行卡管理"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
