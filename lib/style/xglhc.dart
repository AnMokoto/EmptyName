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
/*

  @override
  BoxConstraints get constraints =>
      new BoxConstraints(minWidth: 10.0, maxWidth: 20.0, minHeight: 35.0);

*/
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

  static List<String> plays = [ ];
  static Map<String ,List<dynamic>> oddMap = {};
  factory Stylexglhc.of(String str,List<String> playEns ,Map<String ,List<dynamic>> oddMap1 ) {
    plays = playEns;
    oddMap =oddMap1;
    return const Stylexglhc();
  }

  @override
  String get name => "六合彩";

  @override
  List<String> playEns() {
    return plays;
  }

  @override
  PlayStyle playStyle(String playEn) {
    PlayStyle playStyle = null;
    switch (playEn) {
      case 'xglhc_tmzx':
      case 'xglhc_zmz6t':
      case 'xglhc_zmz5t':
      case 'xglhc_zmz4t':
      case 'xglhc_zmz3t':
      case 'xglhc_zmz2t':
      case 'xglhc_zmz1t':
      case 'xglhc_sx1x':
      case 'xglhc_sxtx':
      case 'xglhc_wstmtw':
      case 'xglhc_tmlm':
      case 'xglhc_zmz6lm':
      case 'xglhc_zmz5lm':
      case 'xglhc_zmz4lm':
      case 'xglhc_zmz3lm':
      case 'xglhc_zmz2lm':
      case 'xglhc_zmz1lm':
      case 'xglhc_zmrx':
         playStyle = cqssc_hz(type: playEn, name: LotPlayConfig.getName(playEn));
       break ;
      case 'xglhc_ws4wl':
      case 'xglhc_ws3wl':
      case 'xglhc_ws2wl':
      case 'xglhc_lmtc':
      case 'xglhc_lm2z1':
      case 'xglhc_lm3z2':
      case 'xglhc_lm2qz':
      case 'xglhc_lm3qz':
      case 'xglhc_bz10':
      case 'xglhc_bz9':
      case 'xglhc_bz8':
      case 'xglhc_bz7':
      case 'xglhc_bz6':
      case 'xglhc_bz5':
        playStyle = xglhc_rx(type: playEn, name: LotPlayConfig.getName(playEn));
        break ;
    }

    if(playStyle!=null){
      playStyle.oddsMap = oddMap;
    }
    return playStyle;
  }
}
