library app.font;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show IconData;

class LotIcon {
  LotIcon._();

  static Icon home(String gameEn) =>
      Icon(getLot(gameEn),color: _homeIconColor(gameEn));

  static _homeIconColor(String gameEn){
    if (gameEn.contains("ssc5")) return Colors.green;
    if (gameEn.contains("ssc3")) return Colors.red;
    if (gameEn.contains("ssc1")) return Colors.redAccent[100];
    if (gameEn.contains("ssc")) return Colors.orange;
    if (gameEn.contains("kl10")) return Colors.deepPurple;
    if (gameEn.contains("11x5")) return Colors.pinkAccent;
    if (gameEn.contains("lhc")) return Colors.blueAccent;
    if (gameEn.contains("pk10")) return Colors.pink;
    if (gameEn.contains("k3")) return Colors.red;
  }

  /**
   * 获取彩种logo
   */
  static IconData getLot(String gameEn) {
    print(gameEn) ;
    if (gameEn.contains("ssc5")) return IconData(0xe609, fontFamily: "Alibaba");
    if (gameEn.contains("ssc3")) return IconData(0xe610, fontFamily: "Alibaba");
    if (gameEn.contains("ssc1")) return IconData(0xe611, fontFamily: "Alibaba");
    if (gameEn.contains("ssc")) return IconData(0xe606, fontFamily: "Alibaba");
    if (gameEn.contains("kl10")) return IconData(0xe603, fontFamily: "Alibaba");
    if (gameEn.contains("11x5")) return IconData(0xe605, fontFamily: "Alibaba");
    if (gameEn.contains("lhc")) return IconData(0xe608, fontFamily: "Alibaba");
    if (gameEn.contains("lhc")) return IconData(0xe608, fontFamily: "Alibaba");
    if (gameEn.contains("pk10")) return IconData(0xe604, fontFamily: "Alibaba");
    if (gameEn.contains("k3")) return IconData(0xe607, fontFamily: "Alibaba");
  }
}
