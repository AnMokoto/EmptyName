import 'package:flutter/material.dart';
import 'package:lowlottery/font/index.dart';

/**
    没有数据
 */
class Nodata {
  static Container nodata(List<dynamic> tickets) {
    if (tickets == null || tickets.length < 1)
      return new Container(
        constraints: new BoxConstraints(
          maxHeight: 140.0,
          minHeight: 20.0,
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: Icon(
                AppIcons.nodata,
                color: Colors.redAccent[100],
                size: 122.0,
              ),
            ),
          ],
        ),
      );
    return null;
  }
}
