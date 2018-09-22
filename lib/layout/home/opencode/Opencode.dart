import 'package:flutter/material.dart';
import 'package:lowlottery/conf/Pk10Color.dart';
import 'package:lowlottery/conf/XglhcColor.dart';
import 'package:lowlottery/font/index.dart';

class OpenCode {
  static String defaultText = '-' ;
  static Container opencode(String gameEn, var _str, int index) {
    if (gameEn == 'pk10') {
      return _pk10(_str, index);
    }
    if (gameEn.contains('xglhc')) {
      return _xglhc(_str, index);
    }
    if (gameEn.contains('k3')) {
//      return _k3(_str, index);
    }

    return _common(_str, index);
  }

  static Container _common(_str, int index) {
    String text = getText(_str, index);
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
          text,
          // _str[index] ?? "-",
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  static Container _xglhc(_str, int index) {
    String text = getText(_str, index);
    return new Container(
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        color: XglhcColor.colors(text),
        shape: BoxShape.circle,
      ),
      width: 28.0,
      height: 28.0,
      child: new Center(
        child: new Text(
          text,
          // _str[index] ?? "-",
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  static String getText(_str, int index) {
    var text = defaultText;
    if(_str.length>1){
      text = _str[index] ;
    }
    return text;
  }

  /**
   * pk10样式
   */
  static Container _pk10(_str, int index) {
    String text = getText(_str, index);
    if(text == defaultText){
      text = '00';
    }
    return new Container(
      margin: EdgeInsets.only(left: 4.0),
      decoration: new BoxDecoration(
//        color: Pk10Color.colors(_str[index]),
        shape: BoxShape.rectangle,
      ),
      width: 20.0,
//      height: 30.0,
      child: new Image.asset(
        'assets/images/ball-pk${text}.png',
        fit: BoxFit.contain,
      ),
    );
  }

  static Container _k3(_str, int index) {
    var icon = AppIcons.shaizi1;
    var va = _str[index];
    if (va == '2') {
      icon = AppIcons.shaizi2;
    } else if (va == '3') {
      icon = AppIcons.shaizi3;
    } else if (va == '4') {
      icon = AppIcons.shaizi4;
    } else if (va == '5') {
      icon = AppIcons.shaizi5;
    } else if (va == '6') {
      icon = AppIcons.shaizi6;
    }
    return new Container(
      /*constraints: BoxConstraints(
        maxHeight: 70.0,
        minWidth: 70.0,
        minHeight: 70.0,
        maxWidth: 70.0,
      ),*/
//      padding: EdgeInsets.all(10.0),
      child: new FittedBox(
        fit: BoxFit.fill,
        child: Icon(icon, color: Colors.red),
      ),
    );
  }
}
