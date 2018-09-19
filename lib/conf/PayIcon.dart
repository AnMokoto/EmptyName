library app.font;

import 'package:flutter/material.dart';
import 'package:lowlottery/font/index.dart';

/**
 * 彩种icon 配置信息
 */
class PayIcon {
  PayIcon._();

  static _homeIconColor(String gameEn) {
    if (gameEn.contains("alipay")) return Colors.blue;
    if (gameEn.contains("qq")) return Colors.blueAccent;
    if (gameEn.contains("weixin")) return Colors.green;
    return Colors.red;
  }

  static Icon pay(String gameEn, double size) => Icon(
        AppIcons.getPay(gameEn),
        color: _homeIconColor(gameEn),
        size: size,
      );
}
