import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Pk10Color.dart';
import 'package:lowlottery/conf/XglhcColor.dart';

class OpenCode {
  static Container opencode(String gameEn, var _str, int index) {
    if (gameEn == 'pk10') {
      return _pk10(_str, index);
    }
    if (gameEn == 'xglhc') {
      return _xglhc(_str, index);
    }

    return _common(_str, index);
  }

  static Container _common(_str, int index) {
    return new Container(
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      width: 28.0,
      height: 28.0,
      child: new Center(
        child: new Text(
          _str.length > 1 ? _str[index] : "-",
          // _str[index] ?? "-",
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  static Container _xglhc(_str, int index) {
    return new Container(
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        color: XglhcColor.colors(_str[index]),
        shape: BoxShape.circle,
      ),
      width: 28.0,
      height: 28.0,
      child: new Center(
        child: new Text(
          _str.length > 1 ? _str[index] : "-",
          // _str[index] ?? "-",
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  /**
   * pk10样式
   */
  static Container _pk10(_str, int index) {
    return new Container(
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        color: Pk10Color.colors(_str[index]),
        shape: BoxShape.rectangle,
      ),
      width: 25.0,
      height: 35.0,
      child: new Center(
        child: new Text(
          _str.length > 1 ? _str[index] : "-",
          // _str[index] ?? "-",
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
