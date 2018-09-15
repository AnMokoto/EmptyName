import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/store/appStore.dart';

class ModefyPwdLayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<ModefyPwdLayer> {
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
        title: new Text("修改登录密码", style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            constraints: BoxConstraints.expand(),
            color: Colors.transparent,
            child: new InkWell(
              onTap: () {
                print("TextInput.hide-----------------------");
                SystemChannels.textInput.invokeMethod("TextInput.hide");
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
          ),
          new Container(
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
                  padding: new EdgeInsets.fromLTRB(leftRightPadding, 50.0,
                      leftRightPadding, topBottomPadding),
                  child: new TextField(
                    autofocus: true,
                    style: hintTips,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: _userNameController,
                    textInputAction: TextInputAction.next,
                    decoration: new InputDecoration(
                      hintText: "原始密码",
                      border: new UnderlineInputBorder(),
                      icon: Icon(Icons.local_phone),
                    ),
                    // obscureText: true,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(leftRightPadding, 50.0,
                      leftRightPadding, topBottomPadding),
                  child: new TextField(
                    autofocus: true,
                    style: hintTips,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: _userPassController,
                    textInputAction: TextInputAction.next,
                    decoration: new InputDecoration(
                      hintText: "新密码",
                      border: new UnderlineInputBorder(),
                      icon: Icon(Icons.local_phone),
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
                            .dispatch(new ModifyPwdRequestAction(context, {
//                          "password": _userNameController.text,
                          "val": _userPassController.text,
                          "key": 'password'
                        }));
                      },
                      child: new Text(
                        '确定修改',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
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
