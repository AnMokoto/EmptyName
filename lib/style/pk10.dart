import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';
import 'package:flutter/material.dart';
import 'Pk10Zhushuzxfx.dart';
import 'ZuheUtil.dart';
import 'style.dart';
import 'package:lowlottery/conf/LotPlay.dart';

///  北京快车
@protected
@reflector
abstract class _pk10 extends PlayStyle {
  _pk10({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  // TODO: implement count
  int get count => 10;

  @protected
  Shape shape(int position, int index) {
    if (type == "pk10_gyhz") {
      return new ShapeRect();
    }
    return new ShapeCircle();
  }

  /*@override
  BoxConstraints get constraints =>
      new BoxConstraints(minWidth: 10.0, maxWidth: 20.0, minHeight: 35.0);
*/
  @override
  LotteryStyle get layerStyle => new LotteryStyleDefault(count: _getCount());

  _getCount() {
    if (type == 'pk10_gyhz') {
      //冠亚和 3个
      return 4;
    }
    return 5;
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
    if (type.contains("pk10_gyhz")) {
      if (d == 0) {
        return "和大";
      }
      if (d == 1) {
        return "和小";
      }
      if (d == 2) {
        return "和单";
      }
      if (d == 3) {
        return "和双";
      }
      return "${d - 1}";
    }
    if (d < 9) return "0${d + 1}";
    return "${d + 1}";
  }
}

@protected
@reflector
class cqssc_hz extends _pk10 {
  @protected
  cqssc_hz(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  // TODO: implement initialCount
  int get initialCount => 21;

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
    state.money = state.zhushu * price* state.beishu;

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
    猜冠军到猜前五
 */
@protected
@reflector
class cqssc_zxfx extends _pk10 {
  cqssc_zxfx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    if (type.contains("5")) return ["冠军", "亚军", "季军", "第四", "第五"];
    if (type.contains("4")) return ["冠军", "亚军", "季军", "第四"];
    if (type.contains("3")) return ["冠军", "亚军", "季军"];
    if (type.contains("2")) return ["冠军", "亚军"];
    if (type.contains("1")) return ["冠军"];
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    state.code = "";
    List<String> value = new List();
    int acount = 1;
    data.forEach((item) {
      List<String> choice = new List();
      int _count = 0;

      /// 当前列表内有效注数
      item.forEach((index) {
        if (index > -1) {
          _count++;
//          var  str = index.toString()+""
          choice.add(forceTransform(index));
        }
      });
      acount = acount * _count;
      String code = transformToWithPoint(choice);
      Log.message("${type}_item===$code");
      value.add(code);
    });

    String code = transformToString(value, type);
    int zhushu = Pk10Zhushuzxfx.calZhushu(code);
    state.zhushu = zhushu;
    state.money = state.zhushu * price* state.beishu;
    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

/**
 * 定位胆
 */
@protected
@reflector
class pk10_dwd extends _pk10 {
  pk10_dwd({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["冠军", "亚军", "季军", "第四", "第五", "第六", "第七", "第八", "第九", "第十"];
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    state.code = "";
    List<String> value = new List();
    int acount = 0;
    data.forEach((item) {
      List<String> choice = new List();
      int _count = 0;

      /// 当前列表内有效注数
      item.forEach((index) {
        if (index > -1) {
          _count++;
          choice.add(forceTransform(index));
        }
      });
      acount = acount + _count;
      String code = transformToWithPoint(choice);
      Log.message("${type}_item===$code");
      value.add(code);
    });

    String code = transformToString(value, type);
    state.zhushu = acount;
    state.money = state.zhushu * price* state.beishu;

    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

class Stylepk10 extends StyleManagerIMPL {
  const Stylepk10();

  static List<String> plays = [ ];
  static Map<String ,List<dynamic>> oddMap = {};
  factory Stylepk10.of(String str,List<String> playEns ,Map<String ,List<dynamic>> oddMap1) {
    plays = playEns;
    oddMap = oddMap1;
    return const Stylepk10();
  }

  @override
  String get name => "pk10";

  @override
  List<String> playEns() {
    return plays;
  }

  @override
  PlayStyle playStyle(String playEn) {
    PlayStyle playStyle = null;
    switch (playEn) {
      case 'pk10_q5zxfx':
      case 'pk10_q4zxfx':
      case 'pk10_q3zxfx':
      case 'pk10_q2zxfx':
      case 'pk10_q1zxfx':
        playStyle = cqssc_zxfx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'pk10_dwd':
        playStyle= pk10_dwd(type: playEn, name: LotPlayConfig.getName(playEn));
        break ;
      case 'pk10_gyhz':
        playStyle =cqssc_hz(type: playEn, name: LotPlayConfig.getName(playEn));
        break ;
    }
    if(playStyle!=null){
      playStyle.oddsMap = oddMap;
    }
    return playStyle;
  }
}
