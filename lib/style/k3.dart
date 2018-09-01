import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lowlottery/log.dart';
import 'ZuheUtil.dart';
import 'style.dart';
import 'package:lowlottery/conf/LotPlay.dart';

class ShapeRect extends Shape {
  @override
  // TODO: implement decoration
  Decoration get decoration => new BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.rectangle,
      border: new Border.all());

  @override
  Decoration get onPressDecoration =>
      new BoxDecoration(color: Colors.red, shape: BoxShape.rectangle);
}

///  快三
@protected
abstract class _k3 extends PlayStyle {
  List<List<int>> _data;

  _k3({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  List<List<int>> initialData(int len) {
    return new List.generate(initialType().length, (index) {
      return new List.generate(len, (i) {
        return -1;
      });
    });
  }

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    _data = initialData(6);
  }

  @override
  List<List<int>> initialArray() {
    return _data;
  }

  @override
  // TODO: implement count
  int get count => 3;

  @protected
  Shape shape(int position, int index) {
    return new ShapeRect();
  }

  @override
  BoxConstraints get constraints =>
      new BoxConstraints(minWidth: 40.0, maxWidth: 60.0, minHeight: 35.0);

  @override
  LotteryStyle get layerStyle => new LotteryStyleDefault(count: 4);

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
class cqssc_hz extends _k3 {
  @protected
  cqssc_hz(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    this._data = initialData(20);
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
class k3_thdx extends _k3 {
  @protected
  k3_thdx(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    this._data = initialData(6);
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
    this._data = initialData(6);
    if (type == 'k3_2bth') {
      numCount = 2;
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
    state.code = "";
    List<String> value = new List();
    _data[0].forEach((f) {
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
class k3_thtx extends _k3 {
  @protected
  k3_thtx(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    this._data = initialData(1);
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

  factory Stylek3.of(String str) {
    return const Stylek3();
  }

  PlayStyle get k3_hz => cqssc_hz(
      type: "k3_hz", name: LotPlayConfig.getName("k3_hz"), desc: "特码直选");
  PlayStyle get k3_3thdx => k3_thdx(
      type: "k3_3thdx", name: LotPlayConfig.getName("k3_3thdx"), desc: "正1特码");
  PlayStyle get k3_3bth => k3_buthdx(
      type: "k3_3bth", name: LotPlayConfig.getName("k3_3bth"), desc: "正2特码");
  PlayStyle get k3_2thfx => k3_thdx(
      type: "k3_2thfx", name: LotPlayConfig.getName("k3_2thfx"), desc: "正3特码");
  PlayStyle get k3_2thdx => k3_thdx(
      type: "k3_2thdx", name: LotPlayConfig.getName("k3_2thdx"), desc: "正4特码");
  PlayStyle get k3_2bth => k3_buthdx(
      type: "k3_2bth", name: LotPlayConfig.getName("k3_2bth"), desc: "���5特码");
  PlayStyle get k3_3thtx => k3_thtx(
      type: "k3_3thtx", name: LotPlayConfig.getName("k3_3thtx"), desc: "正6特码");
  PlayStyle get k3_3lhtx => k3_thtx(
      type: "k3_3lhtx", name: LotPlayConfig.getName("k3_3lhtx"), desc: "正6特码");

  @override
  String get name => "快三";

  @override
  List<PlayStyle> get all => [
        k3_hz,
        k3_3thdx,
        k3_3bth,
        k3_2thfx,
//    k3_2thdx,
        k3_2bth,
        k3_3thtx,
        k3_3lhtx,
      ];
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
