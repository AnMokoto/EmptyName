library app.font;

/**
 * 彩种配置信息
 */
class LotConfig {
  LotConfig._();

  static Map<String, String> _lot = {
    "pk10ffc": "极速赛车",
    "xglhc": "香港六合彩",
    "xglhcffc": "大发六合彩",
    "pk10": "北京PK10",
    "gdkl10": "广东快乐十分",
    "cqkl10": "重庆快乐十分",
    "hunkl10": "湖南快乐十分",
    "gxk3": "广西快三",
    "jsk3": "江苏快三",
    "ahk3": "安徽快三",
    "hubk3": "湖北快三",
    "hebk3": "河北快三",
    "bjk3": "北京快三",
    "gsk3": "甘肃快三",
    "fjk3": "福建快三",
    "nmgk3": "内蒙古快三",
    "gzk3": "贵州快三",
    "shk3": "上海快三",
    "jlk3": "吉林快三",
    "ssc1": "分分彩",
    "ssc3": "三分彩",
    "ssc5": "五分彩",
    "txssc": "腾讯分分彩",
    "cqssc": "重庆时时彩",
    "xjssc": "新疆时时彩",
    "tjssc": "天津时时彩",
    "gd11x5": "广东11选5",
    "nx11x5": "宁夏11选5",
    "ah11x5": "安徽11选5",
    "jl11x5": "11选5",
    "tj11x5": "天津11选5",
    "xj11x5": "新疆11选5",
    "nmg11x5": "内蒙古11选5",
    "yn11x5": "云南11选5",
    "sx11x5": "陕西11选5",
    "qh11x5": "青海11选5",
    "hl11x5": "11选5",
    "gz11x5": "贵州11选5",
    "gx11x5": "广西11选5",
    "js11x5": "江苏11选5",
    "heb11x5": "河北11选5",
    "sd11x5": "山东11选5",
    "fj11x5": "福建11选5",
    "gs11x5": "甘肃11选5",
    "hub11x5": "湖北11选5",
    "ln11x5": "辽宁11选5",
    "sh11x5": "上海11选5",
    "jx11x5": "江西11选5",
    "zj11x5": "浙江11选5",
  };


  /**
   * 获取彩种logo
   */
  static String getLotName(String gameEn) {
    return _lot["$gameEn"] ?? '--';
  }

  static String getLotShortName(String gameEn) {
    if (gameEn.contains("pk10ffc")) return "极速赛车";
    if (gameEn.contains("pk10")) return "PK10";
    if (gameEn.contains("11x5")) return "11选5";
    if (gameEn.contains("k3")) return "快三";
    if (gameEn.contains("lhc")) return "六合彩";
    if (gameEn.contains("ss5")) return "五分彩";
    if (gameEn.contains("ss3")) return "三分彩";
    if (gameEn.contains("ss1")) return "分分彩";
    if (gameEn.contains("txss")) return "分分彩";
    if (gameEn.contains("ssc")) return "时时彩";

    return _lot["$gameEn"] ?? '--';
  }
}
