import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';

import 'Pk10Zhushuzxfx.dart';
import 'ZuheUtil.dart';
import 'style.dart';

///  香港六合彩
@protected
abstract class _xglhc extends PlayStyle {
  List<List<int>> _data;

  _xglhc({@required String type, @required String name, String desc})
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
    if (d < 9) return "0${d+1}";
    return d+1;
  }
}

/**
    猜冠军到猜前五
 */
@protected
class cqssc_zxfx extends _xglhc {
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
    _data.forEach((item) {
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
    state.money = state.zhushu * price;

    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

/**
 * 定位胆
 */
@protected
class pk10_dwd extends _xglhc {
  pk10_dwd({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["冠军", "亚军", "季军", "第四", "第五"];
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
    state.money = state.zhushu * price;

    Log.message("${type}_value===$code");
    state.code = code;

    return state;
  }
}

@protected
class cqssc_hz extends _xglhc {
  @protected
  cqssc_hz(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(49);
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
        value.add(forceTransform(f.toString()));
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

  PlayStyle get tmzx => cqssc_hz(type: "tmzx", name: "特码直选", desc: "特码直选");
  PlayStyle get zmz1t => cqssc_hz(type: "zmz1t", name: "正1特码", desc: "正1特码");

  PlayStyle get zmz2t => cqssc_hz(type: "zmz2t", name: "正2特码", desc: "正2特码");

  PlayStyle get zmz3t => cqssc_hz(type: "zmz3t", name: "正3特码", desc: "正3特码");

  PlayStyle get zmz4t => cqssc_hz(type: "zmz4t", name: "正4特码", desc: "正4特码");

  PlayStyle get zmz5t => cqssc_hz(type: "zmz5t", name: "正5特码", desc: "正5特码");

  PlayStyle get zmz6t => cqssc_hz(type: "zmz6t", name: "正6特码", desc: "正6特码");

  @override
  String get name => "六合彩";

  @override
  List<PlayStyle> get all => [
        tmzx,
        zmz1t,
        zmz2t,
        zmz3t,
        zmz4t,
        zmz5t,
        zmz6t,
      ];
}
/*
* 

  //  香港六合彩特码
  xglhc_tmzx("tmzx", "特码直选"),
  xglhc_tmlm("tmlm", "特码两面"),
  //香港六合彩正码
  xglhc_zmrx("rxzm", "正码任选"),
  xglhc_zmz1t("rxzm", "正码正1特"),
  xglhc_zmz1lm("rxzm", "正码正1两面"),
  xglhc_zmz2t("rxzm", "正码正2特"),
  xglhc_zmz2lm("rxzm", "正码正2两面"),
  xglhc_zmz3t("rxzm", "正码正3特"),
  xglhc_zmz3lm("rxzm", "正码正3两面"),
  xglhc_zmz4t("rxzm", "正码正4特"),
  xglhc_zmz4lm("rxzm", "正码正4两面"),
  xglhc_zmz5t("rxzm", "正码正5特"),
  xglhc_zmz5lm("rxzm", "正码正5两面"),
  xglhc_zmz6t("rxzm", "正码正6特"),
  xglhc_zmz6lm("rxzm", "正码正6两面"),


* */
