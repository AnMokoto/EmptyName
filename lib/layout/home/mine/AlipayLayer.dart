import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/font/index.dart';

class AlipayLayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<AlipayLayer> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  void registerSuccess() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("绑定支付宝", style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, 50.0, leftRightPadding, 10.0),
//              child: new Image.asset(LOGO),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
                child: new TextField(
                  style: hintTips,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: _userNameController,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: "支付宝账号仅限提现使用",
                    border: new UnderlineInputBorder(),
                    icon: Icon(
                      AppIcons.alipay,
                      color: Colors.grey,
                    ),
                  ),
                  // obscureText: true,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
                child: new TextField(
                  style: hintTips,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: _userPassController,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: "务必使用真实姓名",
                    border: new UnderlineInputBorder(),
                    icon: Icon(AppIcons.account),
                  ),
                  // obscureText: true,
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
                      print("the pass is" + _userPassController.text);
                      StoreProvider.of<AppState>(context)
                          .dispatch(new CardRequestAction(context, {
                        "code": _userNameController.text,
                        "realName": _userPassController.text,
                        "cardType": 'alipay'
                      }));
                    },
                    child: new Text(
                      '绑定',
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
