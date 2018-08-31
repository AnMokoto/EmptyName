library app.font;

import 'package:flutter/widgets.dart' show IconData;

class AppIcons {
  AppIcons._();

  //首屏tab
  static IconData jiangbei = IconData(0xe627, fontFamily: "Alibaba");
  static IconData home = IconData(0xe633, fontFamily: "Alibaba");
  static IconData persion = IconData(0xe657, fontFamily: "Alibaba");

  static IconData passwd = IconData(0xe630, fontFamily: "Alibaba");
  static IconData codelanzi = IconData(0xe66c, fontFamily: "Alibaba");

  //个人中心icons
  static IconData projectRecord = IconData(0xe61d, fontFamily: "Alibaba");
  static IconData accountMingxiRecord = IconData(0xe672, fontFamily: "Alibaba");
  static IconData withdrawRecord = IconData(0xe60b, fontFamily: "Alibaba");
  static IconData message = IconData(0xe612, fontFamily: "Alibaba");
  static IconData rechargeRecord = IconData(0xe622, fontFamily: "Alibaba");
  static IconData chongzhi = IconData(0xe646, fontFamily: "Alibaba");
  static IconData tixian = IconData(0xe625, fontFamily: "Alibaba");
  static IconData caishen = IconData(0xe634, fontFamily: "Alibaba");

  static IconData from(int codePoint) =>
      IconData(codePoint, fontFamily: "Alibaba");

  static IconData fromStr(String codePoint) =>
      /*
      IconData(int.parse(codePoint.replaceFirst("&#", "0"), radix: 16),
          fontFamily: "Alibaba");*/
      getLot(codePoint);

  /**
   * 获取彩种logo
   */
  static IconData getLot(String gameEn) {
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
