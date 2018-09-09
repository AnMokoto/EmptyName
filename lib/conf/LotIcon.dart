library app.font;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show IconData;
import 'package:lowlottery/font/index.dart';

/**
 * 彩种icon 配置信息
 */
class LotIcon {
  LotIcon._();

  static Icon home(String gameEn) =>
      Icon(AppIcons.getLot(gameEn), color: _homeIconColor(gameEn));

  static _homeIconColor(String gameEn) {
    if (gameEn.contains("ssc5")) return Colors.deepOrange;
    if (gameEn.contains("ssc3")) return Colors.red;
    if (gameEn.contains("ssc1")) return Colors.redAccent[100];
    if (gameEn.contains("txssc")) return Colors.red;
    if (gameEn.contains("ssc")) return Colors.orange;
    if (gameEn.contains("kl10")) return Colors.deepPurple;
    if (gameEn.contains("11x5")) return Colors.pinkAccent;
    if (gameEn.contains("lhc")) return Colors.blueAccent;
    if (gameEn.contains("pk10")) return Colors.pink;
    if (gameEn.contains("k3")) return Colors.red;
  }

  static Icon logo(String gameEn, double size) => Icon(
        AppIcons.getLot(gameEn),
        color: _homeIconColor(gameEn),
        size: size,
      );
}
