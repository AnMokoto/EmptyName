import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/font/index.dart';

/**
 * 绑定银行卡信息
 */
class CardLayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<CardLayer> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 10.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var province = new TextEditingController();
  var city = new TextEditingController();
  var realName = new TextEditingController();
  var code = new TextEditingController();

  @override
  void registerSuccess() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("绑定银行卡", style: new TextStyle(color: Colors.white)),
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
                    leftRightPadding, topBottomPadding, leftRightPadding, topBottomPadding),
                child: new TextField(
                  style: hintTips,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: province,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: "银行卡开户省份",
                    border: new UnderlineInputBorder(),
                    icon: Icon(AppIcons.province),
                  ),
                  // obscureText: true,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, topBottomPadding, leftRightPadding, topBottomPadding),
                child: new TextField(
                  style: hintTips,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: city,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: "银行卡开户市",
                    border: new UnderlineInputBorder(),
                    icon: Icon(AppIcons.city),
                  ),
                  // obscureText: true,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, topBottomPadding, leftRightPadding, topBottomPadding),
                child: new TextField(
                  style: hintTips,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: realName,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: "开户人姓名",
                    border: new UnderlineInputBorder(),
                    icon: Icon(AppIcons.username),
                  ),
                  // obscureText: true,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(
                    leftRightPadding, topBottomPadding, leftRightPadding, topBottomPadding),
                child: new TextField(
                  style: hintTips,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: code,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    hintText: "银行卡号",
                    border: new UnderlineInputBorder(),
                    icon: Icon(AppIcons.bank_card),
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
                      StoreProvider.of<AppState>(context)
                          .dispatch(new CardRequestAction(context, {
                        "code": code.text,
                        "realName": realName.text,
                        "province": province.text,
                        "city": city.text,
                        "cardType": 'bank'
                      }));
                    },
                    child: new Text(
                      '绑定银行卡',
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
