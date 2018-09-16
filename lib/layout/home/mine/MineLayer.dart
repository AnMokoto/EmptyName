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
import 'package:lowlottery/layout/record/MessageRecord.dart';
import 'package:lowlottery/store/AppStore.dart';
import 'package:lowlottery/style/k3.dart';
import 'package:lowlottery/layout/recharge/Chongzhiqudao.dart';
import 'package:lowlottery/layout/recharge/Withdraw.dart';
import 'AnquanLayer.dart';
class MineLayer extends StatefulWidget {
  _MineState createState() => new _MineState();
}

class _MineState extends State<MineLayer>
    with SingleTickerProviderStateMixin<MineLayer>, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dispatch(context, new UserRequestAction());
    dispatch(context, new UserRequestBalanceAction());
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
                              new Container(
                                margin: EdgeInsets.only(left: 5.0),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                width: 50.0,
                                height: 50.0,
                                child: new ClipOval(
                                  child: new FadeInImage.assetNetwork(
                                    placeholder: "assets/images/app_back.png",
                                    fit: BoxFit.fill,
                                    image: state.avatar ??
                                        "http://p1m4sp0og.bkt.clouddn.com/avatar.png",
                                    width: 60.0,
                                    height: 60.0,
                                  ),
                                ),
                              ),
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
                      //// 钱
                      new StoreConnector<AppState, UserBalance>(
                        builder: (context, state) {
                          return new Container(
                            constraints:
                                new BoxConstraints(minWidth: double.infinity),
                            decoration: new BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: new Column(
                              children: <Widget>[
                                /// header
                                new Container(
                                  color: Colors.grey[100],
                                  child: new Row(children: <Widget>[
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
                                            "${(state.totalBalance ?? 0.0)}",
                                            style: new TextStyle(
                                                color: Colors.red,
                                                fontSize: 22.0),
                                          ),
                                          new ConstrainedBox(
                                            constraints: new BoxConstraints(
                                                minHeight: 38.0,
                                                minWidth: 120.0),
                                            child: new RaisedButton.icon(
                                              textColor: Colors.white,
                                              elevation: 0.0,
                                              // highlightColor: Colors.transparent,
                                              // splashColor: Colors.transparent,
                                              color: Colors.red,
                                              label: new Text("充值"),
                                              icon: new Icon(AppIcons.chongzhi),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            new ChongzhiqudaoLayer()));
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
                                            "${(state.withdrawable ?? 0.0)}",
                                            style: new TextStyle(
                                                color: Colors.red,
                                                fontSize: 22.0),
                                          ),
                                          new ConstrainedBox(
                                            constraints: new BoxConstraints(
                                                minHeight: 38.0,
                                                minWidth: 120.0),
                                            child: new RaisedButton.icon(
                                              textColor: Colors.white,
                                              elevation: 0.0,
                                              // highlightColor: Colors.transparent,
                                              // splashColor: Colors.transparent,
                                              color: Colors.orange,
                                              label: new Text("提现"),
                                              icon: new Icon(AppIcons.tixian),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            new WithdwarLayer(ketixian: double.parse( "${state.withdrawable}").toInt(),
                                                             totalMoney: double.parse( "${state.withdrawable}") + double.parse("${state.totalBalance}")
                                                            )));
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
                          );
                        },
                        converter: (store) {
                          return store.state.userModel.mUserBalance;
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            new Container(
              color: Colors.grey[100],
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
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new MessageLayer(),
                  ));
                },
                leading: Icon(AppIcons.message, color: Colors.red),
                title: new Text("我的消息"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new AnquanLayer(),
                  ));
                },
                leading: Icon(AppIcons.anquan, color: Colors.red),
                title: new Text("安全中心"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),new Container(
              color: Colors.grey[100],
//            margin: EdgeInsets.only(top: 10.0),
              child: new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new AnquanLayer(),
                  ));
                },
                leading: Icon(AppIcons.kefu, color: Colors.red),
                title: new Text("客服中心"),
                trailing: Icon(Icons.navigate_next),
              ),
            ),

            new Container(
              margin: EdgeInsets.only(bottom: 10.0),
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
