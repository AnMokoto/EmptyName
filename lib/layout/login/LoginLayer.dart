import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/font/index.dart';
import 'package:flutter/services.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/layout/register/RegisterLayer.dart';
import 'package:lowlottery/font/index.dart';
class LoginLayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginLayer> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        //禁止pop
        title: new Text("登录", style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          new OutlineButton(
            borderSide: new BorderSide(color: Theme.of(context).primaryColor),
            child: new Text(
              '立即注册',
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new RegisterLayer(),
              ));
            },
          )
        ],
      ),
      body: new SingleChildScrollView(
//        fit: StackFit.expand,
        child: new Container(
          // constraints: new BoxConstraints(maxHeight: 150.0),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
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
                child: new TextFormField(
                  keyboardType: TextInputType.text,
                  style: hintTips,
                  maxLines: 1,
                  controller: _userNameController,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                      hintText: "注册的手机号或者邮箱",
                      border: new UnderlineInputBorder(),
                      icon: Icon(AppIcons.account)),
                  //obscureText: true,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
                child: new TextField(
                  keyboardType: TextInputType.text,
                  style: hintTips,
                  controller: _userPassController,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: new InputDecoration(
                    icon: Icon(AppIcons.passwd),
                    hintText: "登陆密码",
                    border: new UnderlineInputBorder(),
                  ),
                  obscureText: true,
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
                      StoreProvider.of<AppState>(context).dispatch(
                        new LoginRequestAction(
                          context,
                          {
                            "username": _userNameController.text,
                            "pwd": _userPassController.text
                          },
                        ),
                      );
                    },
                    child: new Text(
                      '马上登录',
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
