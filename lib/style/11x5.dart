import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';

import 'Pk10Zhushuzxfx.dart';
import 'ZuheUtil.dart';
import 'style.dart';
import 'package:lowlottery/conf/LotPlay.dart';

///  十一选五
@protected
@reflector
abstract class _11x5 extends PlayStyle {
  _11x5({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  int get count => 5;

  @override
  int get initialCount => 11;

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
    return "${d + 1} ";
  }
}

/**
 * 直选复选
 */
@protected
@reflector
class cqssc_zxfx extends _11x5 {
  cqssc_zxfx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    if (type.contains("3")) return ["第一位", "第二位", "第三位"];
    if (type.contains("2")) return ["第一位", "第二位"];
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
    state.money = state.zhushu * price * state.beishu;

    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

/**
    任选
 */
@protected
@reflector
class gd11x5_rx extends _11x5 {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;
  var leftName = "任选";

  gd11x5_rx(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    super.playReset();
    if (type.endsWith("zxfx")) {
      leftName = "第一位";
    }
    if (type.endsWith("2")) {
      zuheCount = 2;
    } else if (type.endsWith("3")) {
      zuheCount = 3;
    } else if (type.endsWith("4")) {
      zuheCount = 4;
    } else if (type.endsWith("5")) {
      zuheCount = 5;
    } else if (type.endsWith("6")) {
      zuheCount = 6;
    } else if (type.endsWith("7")) {
      zuheCount = 7;
    } else if (type.endsWith("8")) {
      zuheCount = 8;
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
    state.money = state.zhushu * price* state.beishu;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    if (type.endsWith("zxfx")) {
      return ["${leftName}"];
    }
    return ["任选$zuheCount"];
  }
}

/**
    组选
 */
@protected
@reflector
class gd11x5_zux extends _11x5 {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;

  gd11x5_zux(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type.contains("2")) {
      zuheCount = 2;
    } else if (type.contains("3")) {
      zuheCount = 3;
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
    state.money = state.zhushu * price* state.beishu;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["组选"];
  }
}

class Style11x5 extends StyleManagerIMPL {
  const Style11x5();

  static List<String> plays = [];
  static Map<String ,List<dynamic>> oddMap = {};
  factory Style11x5.of(String str,List<String> playEns ,Map<String ,List<dynamic>> oddMap1) {
    plays = playEns;
    oddMap = oddMap1;
    return const Style11x5();
  }

  @override
  String get name => "十一选五";

  @override
  List<String> playEns() {
    return plays;
  }

  @override
  PlayStyle playStyle(String playEn) {
    PlayStyle playStyle = null;
    switch (playEn) {
      case '11x5_rx2':
      case '11x5_rx3':
      case '11x5_rx4':
      case '11x5_rx5':
      case '11x5_rx6':
      case '11x5_rx7':
      case '11x5_rx8':
      case '11x5_q1zxfx':
        playStyle = gd11x5_rx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case '11x5_q2zxfx':
      case '11x5_q3zxfx':
        playStyle =  cqssc_zxfx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case '11x5_q2zuxfx':
      case '11x5_q3zuxfx':
        playStyle = gd11x5_zux(type: playEn, name: LotPlayConfig.getName(playEn));
        break ;
    }

    if(playStyle!=null){
      playStyle.oddsMap = oddMap;
    }
    return playStyle;
  }
}
/*
* //广东11选5
  gd11x5_rx2("rx2", "任选二"),
  gd11x5_rx3("rx3", "任选三"),
  gd11x5_rx4("rx4", "任选四"),
  gd11x5_rx5("rx5", "任选五"),
  gd11x5_rx6("rx6", "任选六"),
  gd11x5_rx7("rx7", "任选七"),
  gd11x5_rx8("rx8", "任选八"),
  gd11x5_q1zxfx("q1zxfx", "前一直选复选"),
  gd11x5_q2zxfx("q2zxfx", "前二直选复选"),
  gd11x5_q3zxfx("q3zxfx", "前三直选复选"),
  gd11x5_q2zuxfx("q2zuxfx", "前二组选复选"),
  gd11x5_q3zuxfx("q3zuxfx", "前三组选复选"),
* */
