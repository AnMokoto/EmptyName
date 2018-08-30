import 'package:flutter/material.dart';
import 'package:lowlottery/layout/record/LotteryBetRecord.dart';
import 'package:lowlottery/layout/login/LoginLayer.dart';
import 'package:lowlottery/layout/register/RegisterLayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/layout/bet/LotteryBetLayer.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/layout/record/WithdrawRecord.dart';
import 'package:lowlottery/layout/record/AccountMingxiRecord.dart';

class MineLayer extends StatefulWidget {
  _MineState createState() => new _MineState();
}

class _MineState extends State<MineLayer>
    with SingleTickerProviderStateMixin<MineLayer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: new AlwaysScrollableScrollPhysics(),
      controller: new ScrollController(),
      child: new Container(
        color: Colors.grey[200],
        child: new Column(
          children: <Widget>[
            new AspectRatio(
              aspectRatio: 1.0,
              child: new Stack(
                // alignment: Alignment.center,
                children: <Widget>[
                  new AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Image.asset(
                      "assets/images/app_back.png",
                      fit: BoxFit.cover,
                    ),
                  ), //

                  new Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(top: 110.0),
                    constraints: new BoxConstraints(minWidth: double.infinity),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                          child: new Column(
                            children: <Widget>[
                              Icon(Icons.whatshot),
                              new Text(
                                "111",
                                style: new TextStyle(
                                    fontSize: 15.0, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        //// 钱
                        new Container(
                          constraints: new BoxConstraints(
                              minWidth: double.infinity, minHeight: 150.0),
                          decoration: new BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(28.0))),
                          child: new Column(
                            children: <Widget>[
                              /// header
                              new Container(
                                color: Colors.grey[100],
                                child: new Row(children: <Widget>[
                                  // child: new Padding(
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 10.0, vertical: 5.0),
                                  new Expanded(
                                    child: new Container(
                                        child: new Column(
                                      children: <Widget>[
                                        new Text(
                                          "可用余额(元)",
                                          style: new TextStyle(
                                              color: Colors.black87),
                                        ),
                                        new Text(
                                          "12.0",
                                          style: new TextStyle(
                                              color: Colors.red,
                                              fontSize: 22.0),
                                        ),
                                        new ConstrainedBox(
                                          constraints: new BoxConstraints(
                                              minHeight: 38.0, minWidth: 120.0),
                                          child: new RaisedButton.icon(
                                            textColor: Colors.white,
                                            elevation: 0.0,
                                            // highlightColor: Colors.transparent,
                                            // splashColor: Colors.transparent,
                                            color: Colors.red,
                                            label: new Text("充值"),
                                            icon: new Icon(AppIcons.chongzhi),
                                            onPressed: () {
                                              /// turn to pay layer
                                              /*StoreProvider.of<AppState>(context).dispatch(
                                                    new LotterBetAdd(item: style.transform));*/
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new LotteryBetLayer()));
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),

                                  new Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: new Container(
                                      color: Colors.grey,
                                      width: .5,
                                      height: 150.0,
                                    ),
                                  ),
// new SizedBox()
                                  new Expanded(
                                    child: new Container(
                                        child: new Column(
                                      children: <Widget>[
                                        new Text(
                                          "可提款余额(元)",
                                          style: new TextStyle(
                                              color: Colors.black87),
                                        ),
                                        new Text(
                                          "100.0",
                                          style: new TextStyle(
                                              color: Colors.red,
                                              fontSize: 22.0),
                                        ),
                                        new ConstrainedBox(
                                          constraints: new BoxConstraints(
                                              minHeight: 38.0, minWidth: 120.0),
                                          child: new RaisedButton.icon(
                                            textColor: Colors.white,
                                            elevation: 0.0,
                                            // highlightColor: Colors.transparent,
                                            // splashColor: Colors.transparent,
                                            color: Colors.orange,
                                            label: new Text("提现"),
                                            icon: new Icon(AppIcons.tixian),
                                            onPressed: () {
                                              /// turn to pay layer
                                              /*StoreProvider.of<AppState>(context).dispatch(
                                                    new LotterBetAdd(item: style.transform));*/
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new LotteryBetLayer()));
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                ]),
                              ),
                            ],
//                          child: new Text("data"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new LotterBetRecordLayer(),
                  ));
                },
                leading: Icon(AppIcons.projectRecord, color: Colors.red),
                title: new Text("投注记录"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),

            new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new AccountRecordLayer(),
                  ));
                },
                leading: Icon(AppIcons.accountMingxiRecord, color: Colors.red),
                title: new Text("账户明细"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new WithdrawRecordLayer(),
                  ));
                },
                leading: Icon(AppIcons.withdrawRecord, color: Colors.red),
                title: new Text("提现记录"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            new Container(
              color: Colors.grey[100],
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new RegisterLayer(),
                  ));
                },
                leading: Icon(Icons.history),
                title: new Text("用户注册"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),new Container(
//            margin: EdgeInsets.only(top: 10.0),
              color: Colors.grey[100],
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new LoginLayer(),
                  ));
                },
                leading: Icon(Icons.history),
                title: new Text("用户登陆"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
