import 'package:flutter/material.dart';
import 'package:lowlottery/store/appStore.dart';
import 'RedUtil.dart';

/**
    消息
 */
class Tickets {
  static ListView build(List<dynamic> tickets) {
    return new ListView.builder(
      itemCount: tickets == null ? 0 : tickets.length,
      itemBuilder: (context, index) {
        var value = tickets[index];
        return new Container(
          constraints: new BoxConstraints(
            maxHeight: 40.0,
            minHeight: 20.0,
          ),
          child: new InkWell(
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          padding: EdgeInsets.all(10.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Container(
                                  width: 80.0,
                                  child: new Text(
                                    "${value["playDesc"] ?? "-"}",
                                    style: new TextStyle(
                                          color: Colors.black54),
                                  )),
                              new Container(
                                  width: 110.0,
                                  child: new Text(
                                    "${value["code"] ?? "-"}",
                                    style: new TextStyle(
                                         color: Colors.black54),
                                  )),
                              new Container(
                                  width: 80.0,
                                  child: new Text(
                                    "${value["zhushu"] ?? "-"}注${value['beishu']}倍",
                                    style: new TextStyle(
                                         color: Colors.black54),
                                  )),
                              new Container(
                                width: 50.0,
                                child: RedUtil.buildText(
                                    "${value['awardMoney']}",
                                    "${value['isRed']}"  )
                              )
                            ],
                          ),
                        ),
                      ),
                      new Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
