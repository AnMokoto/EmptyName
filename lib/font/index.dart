library app.font;

import 'package:flutter/widgets.dart' show IconData;

class AppIcons {
  AppIcons._();

  //首屏tab
  static IconData jiangbei = IconData(0xe627, fontFamily: "Alibaba");
  static IconData home = IconData(0xe633, fontFamily: "Alibaba");
  static IconData persion = IconData(0xe657, fontFamily: "Alibaba");
  static IconData dating = IconData(0xe636, fontFamily: "Alibaba");

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
  static IconData add = IconData(0xe647, fontFamily: "Alibaba");
  static IconData jian = IconData(0xe659, fontFamily: "Alibaba");
//  暂无数据
  static IconData nodata = IconData(0xe734, fontFamily: "Alibaba");
  static IconData shaizi1 = IconData(0xe63b, fontFamily: "Alibaba");
  static IconData shaizi2 = IconData(0xe63c, fontFamily: "Alibaba");
  static IconData shaizi3 = IconData(0xe63d, fontFamily: "Alibaba");
  static IconData shaizi4 = IconData(0xe63f, fontFamily: "Alibaba");
  static IconData shaizi5 = IconData(0xe63e, fontFamily: "Alibaba");
  static IconData shaizi6 = IconData(0xe640, fontFamily: "Alibaba");
  static IconData anquan = IconData(0xe644, fontFamily: "Alibaba");
  static IconData phone = IconData(0xe645, fontFamily: "Alibaba");
  static IconData pwd = IconData(0xe610, fontFamily: "Alibaba");
  static IconData alipay = IconData(0xe684, fontFamily: "Alibaba");
  static IconData weixin =  IconData(0xe751, fontFamily: "Alibaba");
  static IconData qq = IconData(0xe641, fontFamily: "Alibaba");
  static IconData kefu = IconData(0xe761, fontFamily: "Alibaba");

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
    if (gameEn.contains("ssc5")) return IconData(0xe643, fontFamily: "Alibaba");
    if (gameEn.contains("ssc3")) return IconData(0xe642, fontFamily: "Alibaba");
    if (gameEn.contains("ssc1")) return IconData(0xe648, fontFamily: "Alibaba");
    if (gameEn.contains("txssc")) return IconData(0xe638, fontFamily: "Alibaba");
    if (gameEn.contains("ssc")) return IconData(0xe606, fontFamily: "Alibaba");
    if (gameEn.contains("kl10")) return IconData(0xe603, fontFamily: "Alibaba");
    if (gameEn.contains("11x5")) return IconData(0xe605, fontFamily: "Alibaba");
    if (gameEn.contains("lhc")) return IconData(0xe608, fontFamily: "Alibaba");
    if (gameEn.contains("lhc")) return IconData(0xe608, fontFamily: "Alibaba");
    if (gameEn.contains("pk10ffc")) return IconData(0xe635, fontFamily: "Alibaba");
    if (gameEn.contains("pk10")) return IconData(0xe604, fontFamily: "Alibaba");
    if (gameEn.contains("k3")) return IconData(0xe607, fontFamily: "Alibaba");
  }

  static IconData getPay(String gameEn) {
    if (gameEn.contains("alipay")) return alipay;
    if (gameEn.contains("weixin")) return weixin;
    if (gameEn.contains("qq")) return qq;
  }
}
