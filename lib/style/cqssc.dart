import 'style.dart';
import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';
import 'ZuheUtil.dart';

///  重庆时时彩分类
@protected
abstract class _cqssc extends PlayStyle {
  List<List<int>> _data;

  _cqssc({@required String type, @required String name, String desc})
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
  forceTransform(d) {
    return d;
  }

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
}

@protected
class cqssc_1xfx extends _cqssc {
  cqssc_1xfx() : super(type: "ssc_1xfx", desc: "1星复选", name: "1星复选");

  @override
  List<String> initialType() {
    return ["万位", "千位", "百位", "十位", "个位"];
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    var count = 0;

    state.code = "";

    List<String> value = new List();
    _data.forEach((item) {
      List<String> choice = new List();
      item.forEach((index) {
        if (index > -1) {
          ++count;
          choice.add(index.toString());
        }
      });
      state.zhushu = count;
      state.money = count * price;

      String code = transformToWithPoint(choice);
      Log.message("${type}_item===$code");
      value.add(code);
    });

    String code = transformToString(value, type);
    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

@protected
class cqssc_5xzxfx extends _cqssc {
  cqssc_5xzxfx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    if (type.endsWith("5xzxfx"))
      return ["万位", "千位", "百位", "十位", "个位"];
    else if (type.endsWith("4xzxfx")) {
      return ["千位", "百位", "十位", "个位"];
    }
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
    state.zhushu = acount;
    state.money = state.zhushu * price;
    String code = transformToString(value, type);
    Log.message("${type}_value===$code");
    state.code = code;
    return state;
  }
}

@protected
class cqssc_q2fx extends _cqssc {
  cqssc_q2fx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["万位", "千位"];
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

    state.zhushu = acount;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

@protected
class cqssc_h2fx extends cqssc_q2fx {
  cqssc_h2fx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["十位", "个位"];
  }
}

@protected
class cqssc_q3fx extends cqssc_q2fx {
  cqssc_q3fx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["万位", "千位", "百位"];
  }
}

@protected
class cqssc_h3fx extends cqssc_h2fx {
  cqssc_h3fx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["百位", "十位", "个位"];
  }
}

@protected
class cqssc_z3fx extends cqssc_h2fx {
  cqssc_z3fx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["千位", "白位", "十位"];
  }
}

@protected
class cqssc_hz extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_hz(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(19);
    this._zhushu = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
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
        count += this._zhushu[f];
        value.add(f.toString());
      }
    });
    state.zhushu = count;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["和值"];
  }
}

/**
 * 前二后二组选复选
 */
@protected
class cqssc_zuxfx extends _cqssc {
  @protected
  int len = 0;
  cqssc_zuxfx(
      {int len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
    this.len = len;
  }

  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= _data[0].length) return _data;
    _data[0][position] = _data[0][position] == -1 ? position : -1;
    return _data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    state.code = "";
    List<String> value = new List();
    _data[0].forEach((f) {
      if (f > -1) {
        value.add(f.toString());
      }
    });

    var count = ZuheUtil.combination(value.length, len);
    state.zhushu = count.toInt();
    state.money = state.zhushu * price;
    String code = transformToString(value, type);
    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["组选"];
  }
}

/**
 *前二后二组选和值
 */
@protected
class cqssc_zuxhz extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_zuxhz(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(17);
    if (type.contains("2"))
      this._zhushu = [1, 1, 2, 2, 3, 3, 4, 4, 5, 4, 4, 3, 3, 2, 2, 1, 1];
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
        count += this._zhushu[f];
        value.add(f.toString());
      }
    });
    state.zhushu = count;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["和值"];
  }
}

/**
 *前二后二组选包胆
 */
@protected
class cqssc_zuxbd extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_zuxbd(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    //todo 包胆起始位置从1开始，需要特殊处理，暂时未处理
    this._data = initialData(10);
  }
//包胆只能选择一位号码
  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= _data[0].length) return _data;
    for (int i = 0; i < _data[0].length; ++i) {
      _data[0][i] = -1;
    }
    _data[0][position] = _data[0][position] == -1 ? position : -1;
    return _data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    state.code = "";
    List<String> value = new List();
    _data[0].forEach((f) {
      if (f > -1) {
        value.add(f.toString());
      }
    });
    //前二后二组选包胆固定注数 9
    state.zhushu = 9;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["包胆"];
  }
}

/**
 *  一不定
 */
@protected
class cqssc_bd1 extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_bd1(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
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
    state.zhushu = value.length;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["不定位"];
  }
}

/**
 *  二不定，三不定
 */
@protected
class cqssc_bd2 extends _cqssc {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;
  cqssc_bd2(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
    if (type.endsWith("5xsbd")) {
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
    return ["不定位"];
  }
}

/**
 * 前二后二,前三中三后三 跨度
 */
@protected
class cqssc_kd extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_kd(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
    if (type.contains("2"))
      this._zhushu = [10, 18, 16, 14, 12, 10, 8, 6, 4, 2];
    else if (type.contains("3"))
      this._zhushu = [10, 54, 96, 126, 144, 150, 144, 126, 96, 54];
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
        count += this._zhushu[f];
        value.add(f.toString());
      }
    });
    state.zhushu = count;
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message(
        "${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
    state.code = code;

    return state;
  }

  @override
  List<String> initialType() {
    return ["跨度"];
  }
}

@protected
class cqssc_hz3 extends cqssc_hz {
  cqssc_hz3({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(28);
    this._zhushu = [
      1,
      3,
      6,
      10,
      15,
      21,
      28,
      36,
      45,
      55,
      63,
      69,
      73,
      75,
      75,
      73,
      69,
      63,
      55,
      45,
      36,
      28,
      21,
      15,
      10,
      6,
      3,
      1
    ];
  }
}

class Style extends StyleManagerIMPL {
  const Style();

  factory Style.of(String str) {
    return const Style();
//    return   const Style();
  }

  PlayStyle get cqssc1xfx => cqssc_1xfx();

  PlayStyle get cqssq2zxfx =>
      cqssc_q2fx(type: "ssc_q2zxfx", name: "前二直选复选", desc: "前二直选复选");
  PlayStyle get cqssq2zxhz =>
      cqssc_hz(type: "ssc_q2zxhz", name: "前二直选和值", desc: "前二直选和值");
  PlayStyle get cqssq2zxkd =>
      cqssc_kd(type: "ssc_q2zxkd", name: "前二直选跨度", desc: "前二直选跨度");
  PlayStyle get cqssq2zuxfx =>
      cqssc_zuxfx(len: 2, type: "ssc_q2zuxfx", name: "前二组选复选", desc: "前二组选复选");
  PlayStyle get cqssq2zuxhz =>
      cqssc_zuxhz(type: "ssc_q2zuxhz", name: "前二组选和值", desc: "前二组选和值");
  PlayStyle get cqssq2zuxbd =>
      cqssc_zuxbd(type: "ssc_q2zuxbd", name: "前二组选包胆", desc: "前二组选包胆");

  PlayStyle get cqssh2zxfx =>
      cqssc_h2fx(type: "ssc_h2zxfx", name: "后二直选复选", desc: "后二直选复选");
  PlayStyle get cqssh2zxhz =>
      cqssc_hz(type: "ssc_h2zxhz", name: "后二直选和值", desc: "后二直选和值");
  PlayStyle get cqssh2zxkd =>
      cqssc_kd(type: "ssc_h2zxkd", name: "后二直选跨度", desc: "后二直选跨度");
  PlayStyle get cqssh2zuxfx =>
      cqssc_zuxfx(len: 2, type: "ssc_h2zuxfx", name: "后二组选复选", desc: "后二组选复选");
  PlayStyle get cqssh2zuxhz =>
      cqssc_zuxhz(type: "ssc_h2zuxhz", name: "后二组选和值", desc: "后二组选和值");
  PlayStyle get cqssh2zuxbd =>
      cqssc_zuxbd(type: "ssc_h2zuxbd", name: "后二组选包胆", desc: "后二组选包胆");

  PlayStyle get cqssq3zxfx =>
      cqssc_q3fx(type: "ssc_q3zxfx", name: "前三直选复选", desc: "前三直选复选");
  PlayStyle get cqssq3zxhz =>
      cqssc_hz3(type: "ssc_q3zxhz", name: "前三直选和值", desc: "前三直选和值");
  PlayStyle get cqssq3zxkd =>
      cqssc_kd(type: "ssc_z3zxkd", name: "前三直选跨度", desc: "前三直选跨度");
  PlayStyle get cqssq3ybd =>
      cqssc_bd1(type: "ssc_q3ybd", name: "前三一不定码", desc: "前三一不定码");
  PlayStyle get cqssq3ebd =>
      cqssc_bd2(type: "ssc_q3ebd", name: "前三二不定码", desc: "前三二不定码");

  PlayStyle get cqssh3zxfx =>
      cqssc_h3fx(type: "ssc_h3zxfx", name: "后三直选复选", desc: "后三直选复选");
  PlayStyle get cqssh3zxhz =>
      cqssc_hz3(type: "ssc_h3zxhz", name: "后三直选和值", desc: "后三直选和值");
  PlayStyle get cqssh3zxkd =>
      cqssc_kd(type: "ssc_h3zxkd", name: "后三直选跨度", desc: "后三直选跨度");
  PlayStyle get cqssh3ybd =>
      cqssc_bd1(type: "ssc_h3ybd", name: "后三一不定码", desc: "后三一不定码");
  PlayStyle get cqssh3ebd =>
      cqssc_bd2(type: "ssc_h3ebd", name: "后三二不定码", desc: "后三二不定码");

  PlayStyle get cqssz3zxfx =>
      cqssc_z3fx(type: "ssc_z3zxfx", name: "中三直选复选", desc: "中三直选复选");
  PlayStyle get cqssz3zxhz =>
      cqssc_hz3(type: "ssc_z3zxhz", name: "中三直选和值", desc: "中三直选和值");
  PlayStyle get cqssz3zxkd =>
      cqssc_kd(type: "ssc_z3zxkd", name: "中三直选跨度", desc: "中三直选跨度");
  PlayStyle get cqssz3ybd =>
      cqssc_bd1(type: "ssc_z3ybd", name: "中三一不定码", desc: "中三一不定码");
  PlayStyle get cqssz3ebd =>
      cqssc_bd2(type: "ssc_z3ebd", name: "中三二不定码", desc: "中三二不定码");

  PlayStyle get cqssc4xzxfx =>
      cqssc_5xzxfx(type: "ssc_4xzxfx", name: "四星直选复选", desc: "四星直选复选");
  PlayStyle get cqss4xybd =>
      cqssc_bd1(type: "ssc_4xybd", name: "四星一不定码", desc: "四星一不定码");
  PlayStyle get cqss4xebd =>
      cqssc_bd2(type: "ssc_4xebd", name: "四星二不定码", desc: "四星二不定码");

  PlayStyle get cqssc5xzxfx =>
      cqssc_5xzxfx(type: "ssc_5xzxfx", name: "五星直选复选", desc: "五星直选复选");
  PlayStyle get cqss5xybd =>
      cqssc_bd1(type: "ssc_5xybd", name: "五星一不定码", desc: "五星一不定码");
  PlayStyle get cqss5xebd =>
      cqssc_bd2(type: "ssc_5xebd", name: "五星二不定码", desc: "五星二不定码");
  PlayStyle get cqss5xsbd =>
      cqssc_bd2(type: "ssc_5xsbd", name: "五星三不定码", desc: "五星三不定码");

  @override
  String get name => "重庆时时彩";

  @override
  List<PlayStyle> get all => [
        cqssc1xfx,
        cqssq2zxfx,
        cqssq2zxhz,
        cqssq2zxkd,
        cqssq2zuxfx,
        cqssq2zuxhz,
        cqssq2zuxbd,
        cqssh2zxfx,
        cqssh2zxkd,
        cqssh2zxhz,
        cqssh2zuxfx,
        cqssh2zuxbd,
        cqssh2zuxhz,
        cqssq3zxfx,
        cqssq3zxhz,
        cqssq3zxkd,
        cqssq3ybd,
        cqssq3ebd,
        cqssh3zxfx,
        cqssh3zxhz,
        cqssh3zxkd,
        cqssh3ybd,
        cqssh3ebd,
        cqssz3zxfx,
        cqssz3zxhz,
        cqssz3zxkd,
        cqssz3ybd,
        cqssz3ebd,
        cqssc4xzxfx,
        cqss4xybd,
        cqss4xebd,
        cqssc5xzxfx,
        cqss5xybd,
        cqss5xebd,
        cqss5xsbd,
      ];
}

// factory style.cqssc_1xfx() => style(type: "1xfx", desc: "1星复选");
//   //前二
//   factory style.cqssc_q2zxfx() => style(type: "q2zxfx", desc: "前二直选复选");
//   factory style.cqssc_q2zxhz() => style(type: "q2zxhz", desc: "前二直选和值");
//   factory style.cqssc_q2zxkd() => style(type: "q2zxkd", desc: "前二直选跨度");
//   factory style.cqssc_q2zuxfx() => style(type: "q2zuxfx", desc: "前二组选复选");
//   factory style.cqssc_q2zuxhz() => style(type: "q2zuxhz", desc: "前二组选和值");
//   factory style.cqssc_q2zuxbd() => style(type: "q2zuxbd", desc: "前二组选包胆");
//   //后二
//   factory style.cqssc_h2zxfx() => style(type: "h2zxfx", desc: "后二直选复选");
//   factory style.cqssc_h2zxhz() => style(type: "h2zxhz", desc: "后二直选和值");
//   factory style.cqssc_h2zxkd() => style(type: "h2zxkd", desc: "后二��选跨度");
//   factory style.cqssc_h2zuxfx() => style(type: "h2zuxfx", desc: "后二组选复选");
//   factory style.cqssc_h2zuxhz() => style(type: "h2zuxhz", desc: "后二组选和值");
//   factory style.cqssc_h2zuxbd() => style(type: "h2zuxbd", desc: "后二组选包胆");
//   //前三
//   factory style.cqssc_q3zxfx() => style(type: "q3zxfx", desc: "前三直选复选");
//   factory style.cqssc_q3zxhz() => style(type: "q3zxhz", desc: "前三直选和值");
//   factory style.cqssc_q3zxkd() => style(type: "q3zxkd", desc: "前��直选跨度");
//   factory style.cqssc_q3ybd() => style(type: "q3ybd", desc: "���三一码不定位");
//   factory style.cqssc_q3ebd() => style(type: "q3ebd", desc: "前三二码不定位");

//   //后三
//   factory style.cqssc_h3zxfx() => style(type: "h3zxfx", desc: "后三直选复选");
//   factory style.cqssc_h3zxhz() => style(type: "h3zxhz", desc: "后三直选和值");
//   factory style.cqssc_h3zxkd() => style(type: "h3zxkd", desc: "后三直选跨度");
//   factory style.cqssc_h3ybd() => style(type: "h3ybd", desc: "后三一码不定位");
//   factory style.cqssc_h3ebd() => style(type: "h3ebd", desc: "后三��码不定位");
//   //后三
//   factory style.cqssc_z3zxfx() => style(type: "z3zxfx", desc: "中三直选复选");
//   factory style.cqssc_z3zxhz() => style(type: "z3zxhz", desc: "中三直选和值");
//   factory style.cqssc_z3zxkd() => style(type: "z3zxkd", desc: "中三直选跨度");
//   factory style.cqssc_z3ybd() => style(type: "z3ybd", desc: "������������一码不定����");
//   factory style.cqssc_z3ebd() => style(type: "z3ebd", desc: "中三������不��位");
//   //四星
//   factory style.cqssc_4xzxfx() => style(type: "4xzxfx", desc: "四星直选复选");
//   factory style.cqssc_4xybd() => style(type: "4xybd", desc: "四星一码不定位");
//   factory style.cqssc_4xebd() => style(type: "4xebd", desc: "四星二码不定位");

//   //五星
//   factory style.cqssc_5xzxfx() => style(type: "5xzxfx", desc: "五星直选复选");
//   factory style.cqssc_5xybd() => style(type: "5xybd", desc: "五星一码不定位");
//   factory style.cqssc_5xebd() => style(type: "5xebd", desc: "五星二码不定位");
//   factory style.cqssc_5xsbd() => style(type: "5xsbd", desc: "五星三码不定位");
//   //大小单双
//   factory style.cqssc_q2dxds() => style(type: "q2dxds", desc: "前二大小单双");
//   factory style.cqssc_h2dxds() => style(type: "h2dxds", desc: "后二大小单双");
//   factory style.cqssc_q3dxds() => style(type: "q3dxds", desc: "前三大小单双");
//   factory style.cqssc_h3dxds() => style(type: "h3dxds", desc: "后三大小单双");
