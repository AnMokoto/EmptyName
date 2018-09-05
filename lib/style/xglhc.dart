import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/conf/LotPlay.dart';
import 'package:lowlottery/log.dart';

import 'ZuheUtil.dart';
import 'style.dart';

///  香港六合彩
@protected
@reflector
abstract class _xglhc extends PlayStyle {
  _xglhc({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  // TODO: implement count
  int get count => 7;

  @protected
  Shape shape(int position, int index) {
    if (type.endsWith("lm") ||
        type == 'xglhc_tmbb' ||
        type.contains("sx") ||
        type.contains("ws")) {
      return new ShapeRect();
    }
    return new ShapeCircle();
  }

  @override
  BoxConstraints get constraints =>
      new BoxConstraints(minWidth: 10.0, maxWidth: 20.0, minHeight: 35.0);

  @override
  LotteryStyle get layerStyle => new LotteryStyleDefault(count: _getCount());

  _getCount() {
    if (type.contains("sx") || type == 'xglhc_tmbb') {
      //生肖 ,半波 3个
      return 3;
    } else if (type.contains('ws') || type.endsWith("lm")) {
      //尾数 , 两面 4
      return 4;
    }
    return 6;
  }

  /**
   *
      /*
   *
      "xglhc_tmzx": "特码直选",
      "xglhc_tmlm": "特码两面",
      "xglhc_zmrx": "正码任选",
      "xglhc_zmz1t": "正码正1特",
      "xglhc_zmz1lm": "正码正1两面",
      "xglhc_zmz2t": "正码正2特",
      "xglhc_zmz2lm": "正码正2两面",
      "xglhc_zmz3t": "正码正3特",
      "xglhc_zmz3lm": "正码正3两面",
      "xglhc_zmz4t": "正码正4特",
      "xglhc_zmz4lm": "正码正4两面",
      "xglhc_zmz5t": "正码正5特",
      "xglhc_zmz5lm": "正码正5两面",
      "xglhc_zmz6t": "正码正6特",
      "xglhc_zmz6lm": "正码正6两面",
      "xglhc_lm3qz": "连码三全中",
      "xglhc_lm2qz": "连码二全中",
      "xglhc_lm3z2": "连码三中二",
      "xglhc_lm2z1": "连码二中特",
      "xglhc_lmtc": "连码特串",
      "xglhc_tmbb": "特码半波",
      "xglhc_sxtx": "特肖",
      "xglhc_sx1x": "一肖",
      "xglhc_wstmtw": "特码头尾",
      "xglhc_ws2wl": "二尾连",
      "xglhc_ws3wl": "三尾连",
      "xglhc_ws4wl": "四尾连",
      "xglhc_bz5": "五不中",
      "xglhc_bz6": "六不中",
      "xglhc_bz7": "七不中",
      "xglhc_bz8": "八不中",
      "xglhc_bz9": "九不中",
      "xglhc_bz10": "十不中",


   * */
   */
  _getWidth() {
    if (type.contains("tx")) {
      return 20.0;
    } else if (type.contains('hz')) {
      return 40.0;
    }
    return 60.0;
  }

  @override
  List<List<int>> toBet2System(int index, int position) {
    /// 长度拦截
    if (index >= data.length) return data;
    List<int> lis = data[index];

    /// 长度拦截
    if (lis.length <= position) return data;

    /// 替换属性
    lis[position] = lis[position] == position ? -1 : position;
    return data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem model) {
    /// 默认无处理，根据游戏玩法 自己计算
    return model;
  }

  @override
  forceTransform(d) {
    if (type.endsWith("lm")) {
      //两面
      List<String> li = [
        '大',
        '小',
        '单',
        '双',
        '大单',
        '大双',
        '小单',
        '小双',
        '合大',
        '合小',
        '合单',
        '合双',
        '尾大',
        '尾小',
        '家禽',
        '野兽',
        '红波',
        '绿波',
        '蓝波'
      ];
      return li[d];
    }
    if (type == 'xglhc_wstmtw') {
      List<String> li = [
        '0头',
        '1头',
        '2头',
        '3头',
        '4头',
        '0尾',
        '1尾',
        '2尾',
        '3尾',
        '4尾',
        '5尾',
        '6尾',
        '7尾',
        '8尾',
        '9尾',
      ];
      return li[d];
    }
    if (type == 'xglhc_ws2wl' ||
        type == 'xglhc_ws3wl' ||
        type == 'xglhc_ws4wl') {
      List<String> li = [
        '0尾',
        '1尾',
        '2尾',
        '3尾',
        '4尾',
        '5尾',
        '6尾',
        '7尾',
        '8尾',
        '9尾',
      ];
      return li[d];
    }
    if (type.contains('sx')) {
      List<String> li = [
        '鼠',
        '牛',
        '虎',
        '兔',
        '龙',
        '蛇',
        '马',
        '羊',
        '猴',
        '鸡',
        '狗',
        '猪',
      ];
      return li[d];
    }
    if (d < 9) return "0${d + 1}";
    return "${d + 1}";
  }
}

/**
    任选
 */
@protected
@reflector
class xglhc_rx extends _xglhc {
  @protected
  List<int> _zhushu;
  int zuheCount = 5;

  xglhc_rx(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  // TODO: implement initialCount
  int get initialCount => 49;

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type.contains("bz")) {
      //不中
      if (type.endsWith("5")) {
        zuheCount = 5;
      } else if (type.endsWith("6")) {
        zuheCount = 6;
      } else if (type.endsWith("7")) {
        zuheCount = 7;
      } else if (type.endsWith("8")) {
        zuheCount = 8;
      } else if (type.endsWith("9")) {
        zuheCount = 9;
      } else if (type.endsWith("10")) {
        zuheCount = 10;
      }
    } else if (type == 'xglhc_lm3qz' || type == 'xglhc_lm3z2') //连码
    {
      zuheCount = 3;
    } else if (type == 'xglhc_lmtc') //连码
    {
      zuheCount = 1;
    } else if (type == 'xglhc_lm2qz' || type == 'xglhc_lm2z1') //连码
    {
      zuheCount = 2;
    } else if (type.contains("xglhc_ws2wl")) //尾数
    {
      zuheCount = 2;
      this.data = initialData(10);
    } else if (type.contains("xglhc_ws3wl")) //尾数
    {
      zuheCount = 3;
      this.data = initialData(10);
    } else if (type.contains("xglhc_ws4wl")) //尾数
    {
      zuheCount = 4;
      this.data = initialData(10);
    }
  }

  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= data[0].length) return data;
    data[0][position] = data[0][position] == -1 ? position : -1;
    return data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    var count = 0;
    state.code = "";
    List<String> value = new List();
    data[0].forEach((f) {
      if (f > -1) {
        count += 1;
        value.add(forceTransform(f));
      }
    });
    var com = ZuheUtil.combination(value.length, zuheCount);
    state.zhushu = com.toInt();
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return [""];
  }
}

@protected
@reflector
class cqssc_hz extends _xglhc {
  @protected
  int len = 49;

  cqssc_hz({int len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type == 'xglhc_wstmtw') {
      len = 15;
    } else if (type.contains("lm")) {
      len = 19;
    } else if (type.contains("sx")) {
      len = 12;
    }
    this.data = initialData(len);
  }

  @override
  int get initialCount => len;

  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= data[0].length) return data;
    data[0][position] = data[0][position] == -1 ? position : -1;
    return data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    state.code = "";
    List<String> value = new List();
    data[0].forEach((f) {
      if (f > -1) {
        value.add(forceTransform(f));
      }
    });
    state.zhushu = value.length;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return [""];
  }
}

class Stylexglhc extends StyleManagerIMPL {
  const Stylexglhc();

  factory Stylexglhc.of(String str) {
    return const Stylexglhc();
  }

  PlayStyle get tmzx => cqssc_hz(
      type: "xglhc_tmzx",
      name: LotPlayConfig.getName("xglhc_tmzx"),
      desc: "特码直选");

  PlayStyle get zmz1t => cqssc_hz(
      type: "xglhc_zmz1t",
      name: LotPlayConfig.getName("xglhc_zmz1t"),
      desc: "正1特码");

  PlayStyle get zmz2t => cqssc_hz(
      type: "xglhc_zmz2t",
      name: LotPlayConfig.getName("xglhc_zmz2t"),
      desc: "正2特码");

  PlayStyle get zmz3t => cqssc_hz(
      type: "xglhc_zmz3t",
      name: LotPlayConfig.getName("xglhc_zmz3t"),
      desc: "正3特码");

  PlayStyle get zmz4t => cqssc_hz(
      type: "xglhc_zmz4t",
      name: LotPlayConfig.getName("xglhc_zmz4t"),
      desc: "正4特码");

  PlayStyle get zmz5t => cqssc_hz(
      type: "xglhc_zmz5t",
      name: LotPlayConfig.getName("xglhc_zmz5t"),
      desc: "正5特码");

  PlayStyle get zmz6t => cqssc_hz(
      type: "xglhc_zmz6t",
      name: LotPlayConfig.getName("xglhc_zmz6t"),
      desc: "正6特码");

  PlayStyle get xglhc_zmrx => cqssc_hz(
      type: "xglhc_zmrx",
      name: LotPlayConfig.getName("xglhc_zmrx"),
      desc: "正码任选");

  PlayStyle get xglhc_zmz1lm => cqssc_hz(
      type: "xglhc_zmz1lm",
      name: LotPlayConfig.getName("xglhc_zmz1lm"),
      desc: "正码两面");

  PlayStyle get xglhc_zmz2lm => cqssc_hz(
      type: "xglhc_zmz2lm",
      name: LotPlayConfig.getName("xglhc_zmz2lm"),
      desc: "正码两面");

  PlayStyle get xglhc_zmz3lm => cqssc_hz(
      type: "xglhc_zmz3lm",
      name: LotPlayConfig.getName("xglhc_zmz3lm"),
      desc: "正码两面");

  PlayStyle get xglhc_zmz4lm => cqssc_hz(
      type: "xglhc_zmz4lm",
      name: LotPlayConfig.getName("xglhc_zmz4lm"),
      desc: "正码两面");

  PlayStyle get xglhc_zmz5lm => cqssc_hz(
      type: "xglhc_zmz5lm",
      name: LotPlayConfig.getName("xglhc_zmz5lm"),
      desc: "正码两面");

  PlayStyle get xglhc_zmz6lm => cqssc_hz(
      type: "xglhc_zmz6lm",
      name: LotPlayConfig.getName("xglhc_zmz6lm"),
      desc: "正码两面");

  PlayStyle get xglhc_tmlm => cqssc_hz(
      type: "xglhc_tmlm",
      name: LotPlayConfig.getName("xglhc_tmlm"),
      desc: "特码两面");

  PlayStyle get xglhc_wstmtw => cqssc_hz(
      type: "xglhc_wstmtw",
      name: LotPlayConfig.getName("xglhc_wstmtw"),
      desc: "特码头尾");

  PlayStyle get xglhc_sxtx => cqssc_hz(
      type: "xglhc_sxtx",
      name: LotPlayConfig.getName("xglhc_sxtx"),
      desc: "特肖");

  PlayStyle get xglhc_sx1x => cqssc_hz(
      type: "xglhc_sx1x",
      name: LotPlayConfig.getName("xglhc_sx1x"),
      desc: "一肖");

  PlayStyle get xglhc_bz5 => xglhc_rx(
      type: "xglhc_bz5", name: LotPlayConfig.getName("xglhc_bz5"), desc: "不中5");

  PlayStyle get xglhc_bz6 => xglhc_rx(
      type: "xglhc_bz6", name: LotPlayConfig.getName("xglhc_bz6"), desc: "不中6");

  PlayStyle get xglhc_bz7 => xglhc_rx(
      type: "xglhc_bz7", name: LotPlayConfig.getName("xglhc_bz7"), desc: "不中7");

  PlayStyle get xglhc_bz8 => xglhc_rx(
      type: "xglhc_bz8", name: LotPlayConfig.getName("xglhc_bz8"), desc: "不中8");

  PlayStyle get xglhc_bz9 => xglhc_rx(
      type: "xglhc_bz9", name: LotPlayConfig.getName("xglhc_bz9"), desc: "不中9");

  PlayStyle get xglhc_bz10 => xglhc_rx(
      type: "xglhc_bz10",
      name: LotPlayConfig.getName("xglhc_bz10"),
      desc: "不中10");

  PlayStyle get xglhc_lm3qz => xglhc_rx(
      type: "xglhc_lm3qz",
      name: LotPlayConfig.getName("xglhc_lm3qz"),
      desc: "三全中");

  PlayStyle get xglhc_lm2qz => xglhc_rx(
      type: "xglhc_lm2qz",
      name: LotPlayConfig.getName("xglhc_lm2qz"),
      desc: "2全中");

  PlayStyle get xglhc_lm3z2 => xglhc_rx(
      type: "xglhc_lm3z2",
      name: LotPlayConfig.getName("xglhc_lm3z2"),
      desc: "三中二");

  PlayStyle get xglhc_lm2z1 => xglhc_rx(
      type: "xglhc_lm2z1",
      name: LotPlayConfig.getName("xglhc_lm2z1"),
      desc: "二中特");

  PlayStyle get xglhc_lmtc => xglhc_rx(
      type: "xglhc_lmtc",
      name: LotPlayConfig.getName("xglhc_lmtc"),
      desc: "特串");

  PlayStyle get xglhc_ws2wl => xglhc_rx(
      type: "xglhc_ws2wl",
      name: LotPlayConfig.getName("xglhc_ws2wl"),
      desc: "二尾连");

  PlayStyle get xglhc_ws3wl => xglhc_rx(
      type: "xglhc_ws3wl",
      name: LotPlayConfig.getName("xglhc_ws3wl"),
      desc: "三尾连");

  PlayStyle get xglhc_ws4wl => xglhc_rx(
      type: "xglhc_ws4wl",
      name: LotPlayConfig.getName("xglhc_ws4wl"),
      desc: "四尾连");

  @override
  String get name => "六合彩";

  @override
  List<PlayStyle> get all => [
        xglhc_sxtx,
        xglhc_sx1x,
        xglhc_ws2wl,
        xglhc_ws3wl,
        xglhc_ws4wl,
        xglhc_wstmtw,
        xglhc_lm3qz,
        xglhc_lm2qz,
        xglhc_lm3z2,
        xglhc_lm2z1,
        xglhc_lmtc,
        xglhc_bz5,
        xglhc_bz6,
        xglhc_bz7,
        xglhc_bz8,
        xglhc_bz9,
        xglhc_bz10,
        xglhc_zmz1lm,
        tmzx,
        xglhc_zmrx,
        zmz1t,
        zmz2t,
        zmz3t,
        zmz4t,
        zmz5t,
        zmz6t,
        xglhc_tmlm,
        xglhc_zmz2lm,
        xglhc_zmz3lm,
        xglhc_zmz4lm,
        xglhc_zmz5lm,
        xglhc_zmz6lm,

        /*
        xglhc_tmbb,
       
        ,
       */
      ];
}
/*
* 
"xglhc_tmzx": "特码直选",
"xglhc_tmlm": "特码两面",
"xglhc_zmrx": "正码任选",
"xglhc_zmz1t": "正码正1特",
"xglhc_zmz1lm": "正码正1两面",
"xglhc_zmz2t": "正码正2特",
"xglhc_zmz2lm": "正码正2两面",
"xglhc_zmz3t": "正码正3特",
"xglhc_zmz3lm": "正码正3两面",
"xglhc_zmz4t": "正码正4特",
"xglhc_zmz4lm": "正码正4两面",
"xglhc_zmz5t": "正码正5特",
"xglhc_zmz5lm": "正码正5两面",
"xglhc_zmz6t": "正码正6特",
"xglhc_zmz6lm": "正码正6两面",
"xglhc_lm3qz": "连码三全中",
"xglhc_lm2qz": "连码二全中",
"xglhc_lm3z2": "连码三中二",
"xglhc_lm2z1": "连码二中特",
"xglhc_lmtc": "连码特串",
"xglhc_tmbb": "特码半波",
"xglhc_sxtx": "特肖",
"xglhc_sx1x": "一肖",
"xglhc_wstmtw": "特码头尾",
"xglhc_ws2wl": "二尾连",
"xglhc_ws3wl": "三尾连",
"xglhc_ws4wl": "四尾连",
"xglhc_bz5": "五不中",
"xglhc_bz6": "六不中",
"xglhc_bz7": "七不中",
"xglhc_bz8": "八不中",
"xglhc_bz9": "九不中",
"xglhc_bz10": "十不中",


* */
