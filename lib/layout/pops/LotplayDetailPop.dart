import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LotPlayDetailPop {
  /**
   * 通用弹框
   */
  static void lotPlayDetail(
      BuildContext context, String title, String data, List<dynamic> odds) {
    Container container = new Container();
    ListView listView = new ListView();
    var leftstyle = new TextStyle(
      fontSize: 14.0,
      color: Colors.grey,
    );
    var style = new TextStyle(fontSize: 14.0, color: Colors.red);
    List<Widget> li = [];
    li.add(new Text(
      data,
      style: leftstyle,
    ));
    if (odds != null && odds.length > 0) {
      for (var value in odds) {
        container = new Container(
          margin: EdgeInsets.all(5.0),
          child: new Row(
            children: <Widget>[
              new Container(
                width:100.0,
                child: new Text('号码：${value["key"]}' , style: new TextStyle(color: Colors.grey),),
              ),
              new Expanded(child: new Text('赔率： ${value["odd"]}' ,style: new TextStyle(color: Colors.redAccent),)),
            ],
          ),
        );
        li.add(container);
      }
    }

    showDialog(
      context: context,
      builder: (context) => new CupertinoAlertDialog(
            title: new Text(title),
            content: new Container(
              child: new Column(
                children: li,
              ),
            ),
            actions: <Widget>[
              new CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(
                  "确定",
                  style: style,
                ),
              ),
            ],
          ),
    );
  }
}
