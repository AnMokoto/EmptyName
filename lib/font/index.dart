library app.font;

import 'package:flutter/widgets.dart' show IconData;

class AppIcons {
  AppIcons._();

  static IconData passwd = IconData(0xe630, fontFamily: "Alibaba");

  static IconData from(int codePoint) =>
      IconData(codePoint, fontFamily: "Alibaba");

  static IconData fromStr(String codePoint) =>
      IconData(int.parse(codePoint.replaceAll("&#x", "0x"), radix: 16),
          fontFamily: "Alibaba");

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
