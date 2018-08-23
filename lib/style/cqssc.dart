import 'style.dart';
import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';

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
  cqssc_1xfx() : super(type: "1xfx", desc: "1星复选", name: "1星复选");

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
    int acount = 0;
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



class Style extends StyleManagerIMPL{
  const Style();


  factory Style.of(String str) {
    return str.contains("ssc") ? const Style() : null;
  }

  PlayStyle get cqssc1xfx => cqssc_1xfx();

  PlayStyle get cqssq2zxfx =>
      cqssc_q2fx(type: "q2zxfx", name: "前二直选复选", desc: "前二直选复选");
  PlayStyle get cqssq2zxhz =>
      cqssc_hz(type: "q2zxhz", name: "前二直选和值", desc: "前二直选和值");

  PlayStyle get cqssh2zxfx =>
      cqssc_h2fx(type: "h2zxfx", name: "后二直选复选", desc: "后二直选复选");
  PlayStyle get cqssh2zxhz =>
      cqssc_hz(type: "h2zxhz", name: "后二直选和值", desc: "后二直选和值");

  PlayStyle get cqssq3zxfx =>
      cqssc_q3fx(type: "q3zxfx", name: "前三直选复选", desc: "前三直选复选");
  PlayStyle get cqssq3zxhz =>
      cqssc_hz3(type: "q3zxhz", name: "前三直选和值", desc: "前三直选和值");

  PlayStyle get cqssh3zxfx =>
      cqssc_h3fx(type: "h3zxfx", name: "后三直选复选", desc: "后三直选复选");
  PlayStyle get cqssh3zxhz =>
      cqssc_hz3(type: "h3zxhz", name: "后三直选和值", desc: "后三直选和值");

@override
  String get name=>"重庆时时彩";



 @override
  List<PlayStyle> get all => [
        cqssc1xfx,
        cqssq2zxfx,
        cqssq2zxhz,
        cqssh2zxfx,
        cqssh2zxhz,
        cqssq3zxfx,
        cqssq3zxhz,
        cqssh3zxfx,
        cqssh3zxhz
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
