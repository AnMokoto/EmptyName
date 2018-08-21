import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RegisterContract.dart';
import 'package:lowlottery/common/mvp.dart';


class RegisterLayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState(new RegisterPresenter());
  }
}

class _LoginPageState extends MVPState<RegisterPresenter, RegisterLayer>
    with RegisterIView {

  _LoginPageState(RegisterPresenter p) : super(p);

  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "images/oschina.png";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("注册", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
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
                controller: _userNameController,
                decoration: new InputDecoration(hintText: "手机号或者邮箱"),
                obscureText: true,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userPassController,
                decoration: new InputDecoration(hintText: "设置6-12位密码"),
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
                      presenter
                          .register(
                          {
                            "username": _userNameController.text,
                            "pwd": _userPassController.text
                          })
                          .then((e) {
                        ////
                      });
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        '立即注册',
                        style:
                        new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}