import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';

import 'Pk10Zhushuzxfx.dart';
import 'ZuheUtil.dart';
import 'style.dart';

///  十一选五
@protected
abstract class _11x5 extends PlayStyle {
  List<List<int>> _data;

  _11x5({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    _data = initialData(10);
  }

  List<List<int>> initialData(int len) {
    return new List.generate(initialType().length, (index) {
      return new List.generate(len, (i) {
        return -1;
      });
    });
  }

  @override
  List<List<int>> initialArray() {
    return _data;
  }

  @override
  // TODO: implement count
  int get count => 5;

  @override
  List<List<int>> toBet2System(int index, int position) {
    /// 长度拦截
    if (index >= _data.length) return _data;
    List<int> lis = _data[index];

    /// 长度拦截
    if (lis.length <= position) return _data;

    /// 替换属性
    lis[position] = lis[position] == position ? -1 : position;
    return _data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem model) {
    /// 默认无处理，根据游戏玩法 自己计算
    return model;
  }

  @override
  forceTransform(d) {
    return d;
  }
}

/**
 * 直选复选
 */
@protected
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
    _data.forEach((item) {
      List<String> choice = new List();
      int _count = 0;

      /// 当前列表内有效注数
      item.forEach((index) {
        if (index > -1) {
          _count++;
          choice.add(index.toString());
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
    state.money = state.zhushu * price;

    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

/**
    任选
 */
@protected
class gd11x5_rx extends _11x5 {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;

  gd11x5_rx(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(12);
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
    if (position >= _data[0].length) return _data;
    _data[0][position] = _data[0][position] == -1 ? position : -1;
    return _data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    var count = 0;
    state.code = "";
    List<String> value = new List();
    _data[0].forEach((f) {
      if (f > -1) {
        count += 1;
        value.add(f.toString());
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
    return ["任选$zuheCount"];
  }
}

/**
    组选
 */
@protected
class gd11x5_zux extends _11x5 {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;

  gd11x5_zux(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(12);
    if (type.contains("2")) {
      zuheCount = 2;
    } else if (type.contains("3")) {
      zuheCount = 3;
    }
  }

  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= _data[0].length) return _data;
    _data[0][position] = _data[0][position] == -1 ? position : -1;
    return _data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    var count = 0;
    state.code = "";
    List<String> value = new List();
    _data[0].forEach((f) {
      if (f > -1) {
        count += 1;
        value.add(f.toString());
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
    return ["组选"];
  }
}

class Style11x5 extends StyleManagerIMPL {
  const Style11x5();

  factory Style11x5.of(String str) {
    return const Style11x5();
//    return   const Style();
  }

  PlayStyle get gd11x5rx2 =>
      gd11x5_rx(type: "11x5_rx2", name: "任选二", desc: "任选二");

  PlayStyle get gd11x5rx3 =>
      gd11x5_rx(type: "11x5_rx3", name: "任选三", desc: "任选三");

  PlayStyle get gd11x5rx4 =>
      gd11x5_rx(type: "11x5_rx4", name: "任选四", desc: "任选四");

  PlayStyle get gd11x5rx5 =>
      gd11x5_rx(type: "11x5_rx5", name: "任选五", desc: "任选五");

  PlayStyle get gd11x5rx6 =>
      gd11x5_rx(type: "11x5_rx6", name: "任选六", desc: "任选六");

  PlayStyle get gd11x5rx7 =>
      gd11x5_rx(type: "11x5_rx7", name: "任选七", desc: "任选七");

  PlayStyle get gd11x5rx8 =>
      gd11x5_rx(type: "11x5_rx8", name: "任选八", desc: "任选八");

  PlayStyle get gd11x5q1zxfx =>
      gd11x5_rx(type: "11x5_q1zxfx", name: "前一直选复选", desc: "前一直选复选");

  PlayStyle get gd11x5q2zxfx =>
      cqssc_zxfx(type: "11x5_q2zxfx", name: "前二直选复选", desc: "前二直选复选");

  PlayStyle get gd11x5q3zxfx =>
      cqssc_zxfx(type: "11x5_q3zxfx", name: "前三直选复选", desc: "前三直选复选");

  PlayStyle get gd11x5q2zuxfx =>
      gd11x5_zux(type: "11x5_q2zuxfx", name: "前二组选复选", desc: "前二组选复选");

  PlayStyle get gd11x5q3zuxfx =>
      gd11x5_zux(type: "11x5_q3zuxfx", name: "前三组选复选", desc: "前三组选复选");

  @override
  String get name => "十一选五";

  @override
  List<PlayStyle> get all => [
        gd11x5rx2,
        gd11x5rx3,
        gd11x5rx4,
        gd11x5rx5,
        gd11x5rx6,
        gd11x5rx7,
        gd11x5rx8,
        gd11x5q1zxfx,
        gd11x5q2zxfx,
        gd11x5q3zxfx,
        gd11x5q2zuxfx,
        gd11x5q3zuxfx,
      ];
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
