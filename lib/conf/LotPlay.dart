library app.font;

/**
 * 彩种玩法配置信息
 */
class LotPlayConfig {
  LotPlayConfig._();

  static Map<String, String> _lotPlay = {
    "ssc_1xfx": "1星复选",
    "ssc_q2zxfx": "前二直选复选",
    "ssc_q2zxhz": "前二直选和值",
    "ssc_q2zxkd": "前二直选跨度",
    "ssc_q2zuxfx": "前二组选复选",
    "ssc_q2zuxhz": "前二组选和值",
    "ssc_q2zuxbd": "前二组选包胆",
    "ssc_h2zxfx": "后二直选复选",
    "ssc_h2zxhz": "后二直选和值",
    "ssc_h2zxkd": "后二直选跨度",
    "ssc_h2zuxfx": "后二组选复选",
    "ssc_h2zuxhz": "后二组选和值",
    "ssc_h2zuxbd": "后二组选包胆",
    "ssc_q3zxfx": "前三直选复选",
    "ssc_q3zxhz": "前三直选和值",
    "ssc_q3zxkd": "前三直选跨度",
    "ssc_q3ybd": "前三一码不定位",
    "ssc_q3ebd": "前三二码不定位",
    "ssc_h3zxfx": "后三直选复选",
    "ssc_h3zxhz": "后三直选和值",
    "ssc_h3zxkd": "后三直选跨度",
    "ssc_h3ybd": "后三一码不定位",
    "ssc_h3ebd": "后三二码不定位",
    "ssc_z3zxfx": "中三直选复选",
    "ssc_z3zxhz": "中三直选和值",
    "ssc_z3zxkd": "中三直选跨度",
    "ssc_z3ybd": "中三一码不定位",
    "ssc_z3ebd": "中三二码不定位",
    "ssc_4xzxfx": "四星直选复选",
    "ssc_4xybd": "四星一码不定位",
    "ssc_4xebd": "四星二码不定位",
    "ssc_5xzxfx": "五星直选复选",
    "ssc_5xybd": "五星一码不定位",
    "ssc_5xebd": "五星二码不定位",
    "ssc_5xsbd": "五星三码不定位",
    "ssc_q2dxds": "前二大小单双",
    "ssc_h2dxds": "后二大小单双",
    "ssc_q3dxds": "前三大小单双",
    "ssc_h3dxds": "后三大小单双",
    "pk10_dwd": "定位胆",
    "pk10_q5zxfx": "前五直选复选",
    "pk10_q4zxfx": "前四直选复选",
    "pk10_q3zxfx": "前三直选复选",
    "pk10_q2zxfx": "前二直选复选",
    "pk10_q1zxfx": "前一直选复选",
    "kl10_rx2": "任选二",
    "kl10_rx3": "任选三",
    "kl10_rx4": "任选四",
    "kl10_rx5": "任选五",
    "kl10_rx6": "任选六",
    "kl10_rx7": "任选七",
    "kl10_rx8": "任选八",
    "kl10_q1zxfx": "前一直选复选",
    "kl10_q2zxfx": "前二直选复选",
    "kl10_q3zxfx": "前三直选复选",
    "kl10_q2zuxfx": "前二组选复选",
    "kl10_q3zuxfx": "前三组选复选",
    "k3_hz": "和值",
    "k3_3thdx": "三同号单选",
    "k3_3bth": "三不同号",
    "k3_2thfx": "二同号复选",
    "k3_2thdx": "二同号单选",
    "k3_2bth": "二不同号",
    "k3_3thtx": "三同号通选",
    "k3_3lhtx": "三连号通选",
    "11x5_rx2": "任选二",
    "11x5_rx3": "任选三",
    "11x5_rx4": "任选四",
    "11x5_rx5": "任选五",
    "11x5_rx6": "任选六",
    "11x5_rx7": "任选七",
    "11x5_rx8": "任选八",
    "11x5_q1zxfx": "前一直选复选",
    "11x5_q2zxfx": "前二直选复选",
    "11x5_q3zxfx": "前三直选复选",
    "11x5_q2zuxfx": "前二组选复选",
    "11x5_q3zuxfx": "前三组选复选",
    "tmzx": "特码直选",
    "tmlm": "特码两面",
    "rxzm": "正码任选",
  };

  /**
   * 获取彩种名称
   */
  static String getName(String playEn) {
//    print(gameEn);
    return _lotPlay["$playEn"] ?? '--';
  }
}
