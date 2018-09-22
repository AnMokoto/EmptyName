import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/log.dart';
import 'ZuheUtil.dart';
import 'style.dart';
import 'package:lowlottery/conf/LotPlay.dart';

///  快三
@protected
@reflector
abstract class _k3 extends PlayStyle {
  _k3({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  int get initialCount => 6;

  @override
  int get count => 3;

  @protected
  Shape shape(int position, int index) {
    return new ShapeRect();
  }

/*
  @override
  BoxConstraints get constraints =>
      new BoxConstraints(minWidth: 10.0, maxWidth: 20.0, minHeight: 35.0);
*/

  @override
  LotteryStyle get layerStyle => new LotteryStyleDefault(count: _getCount());

  _getCount() {
    if (type.contains("tx")) {
      return 1;
    } else if (type.contains('hz')) {
      return 4;
    }
    return 6;
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
//    if (d < 9) return "${d+2}";
    if (type == 'k3_3thdx') {
      return "${d + 1}${d + 1}${d + 1}";
    }
    if (type == 'k3_2thfx') {
      return "${d + 1}${d + 1}";
    }
    if (type == 'k3_hz') {
      if (d == 0) {
        return "大";
      }
      if (d == 1) {
        return "小";
      }
      if (d == 2) {
        return "单";
      }
      if (d == 3) {
        return "双";
      }
      return "${d - 1}";
    }
    if (type == 'k3_3thtx') {
      return "111 222 333 444 555 666";
    }
    if (type == 'k3_3lhtx') {
      return "123 234 345 456";
    }
    return "${d + 1}";
  }
}

@protected
@reflector
class k3_hzs extends _k3 {
  @protected
  k3_hzs(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  int get initialCount => 20;

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

@protected
@reflector
class k3_thdx extends _k3 {
  @protected
  k3_thdx(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  int get initialCount => 6;

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

/**
 * 3不同号 , 2不同号
 */
@protected
@reflector
class k3_buthdx extends _k3 {
  @protected
  int numCount = 3;

  k3_buthdx(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type == 'k3_2bth') {
      numCount = 2;
    }
  }

  @override
  int get initialCount => 6;

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
    state.zhushu = ZuheUtil.combination(value.length, numCount).toInt();
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

@protected
@reflector
class k3_thtx extends _k3 {
  @protected
  k3_thtx(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  int get initialCount => 1;

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
    state.zhushu = 1;
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

class Stylek3 extends StyleManagerIMPL {
  const Stylek3();

  static List<String> plays = [];
  static Map<String ,List<dynamic>> oddMap = {};
  factory Stylek3.of(String str,List<String> playEns ,Map<String ,List<dynamic>> oddMap1) {
    plays = playEns;
    oddMap = oddMap1;
    return const Stylek3();
  }

  // external
  factory Stylek3.from() {
    return const Stylek3();
  }

  @override
  String get name => "快三";

  @override
  List<String> playEns() {
    return plays;
  }

  @override
  PlayStyle playStyle(String playEn) {
    PlayStyle playStyle = null;
    switch (playEn) {
      case 'k3_hz':
        playStyle= k3_hzs(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'k3_3thdx':
      case 'k3_2thfx':
      case 'k3_2thdx':
        playStyle= k3_thdx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'k3_3thtx':
      case 'k3_3lhtx':
        playStyle = k3_thtx(type: playEn, name: LotPlayConfig.getName(playEn));
        break ;
      case 'k3_3bth':
      case 'k3_2bth':
        playStyle= k3_buthdx(type: playEn, name: LotPlayConfig.getName(playEn));
        break ;
    }
    if(playStyle!=null){
      playStyle.oddsMap= oddMap;
    }
    return playStyle;
  }
}
/*
* 
"k3_hz": "和值",
"k3_3thdx": "三同号单选",
"k3_3bth": "三不同号",
"k3_2thfx": "二同号复选",
"k3_2thdx": "二同号单选",
"k3_2bth": "二不同号",
"k3_3thtx": "三同号通选",
"k3_3lhtx": "三连号通选",



* */
