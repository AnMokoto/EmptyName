import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CommonPop {
  /**
   * 通用弹框
   */
  static void pop(BuildContext context, String title, String data) {
    var leftstyle = new TextStyle(
      fontSize: 14.0,
      color: Colors.black54,
    );
    var style = new TextStyle(fontSize: 14.0, color: Colors.red);
    List<Widget> li = [];
    li.add(new Text(
      data,
      style: leftstyle,
    ));

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
