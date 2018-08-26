import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';

import 'Pk10Zhushuzxfx.dart';
import 'ZuheUtil.dart';
import 'style.dart';

///  北京快车
@protected
abstract class _pk10 extends PlayStyle {
  List<List<int>> _data;

  _pk10({@required String type, @required String name, String desc})
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
    if(d<10) return "0$d"  ;
    return d;
  }
}

/**
    猜冠军到猜前五
 */
@protected
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

class Stylepk10 extends StyleManagerIMPL {
  const Stylepk10();

  factory Stylepk10.of(String str) {
    return const Stylepk10();
  }

  PlayStyle get pk10dwd => pk10_dwd(type: "pk10_dwd", name: "定位胆", desc: "定位胆");

  PlayStyle get pk10q5zxfx =>
      cqssc_zxfx(type: "pk10_q5zxfx", name: "猜前五", desc: "猜前五");

  PlayStyle get pk10q4zxfx =>
      cqssc_zxfx(type: "pk10_q4zxfx", name: "猜前四", desc: "猜前四");

  PlayStyle get pk10q3zxfx =>
      cqssc_zxfx(type: "pk10_q3zxfx", name: "猜前三", desc: "猜前三");

  PlayStyle get pk10q2zxfx =>
      cqssc_zxfx(type: "pk10_q2zxfx", name: "猜前二", desc: "猜前二");

  PlayStyle get pk10q1zxfx =>
      cqssc_zxfx(type: "pk10_q1zxfx", name: "猜冠军", desc: "猜冠军");

  @override
  String get name => "pk10";

  @override
  List<PlayStyle> get all => [
        pk10dwd,
        pk10q5zxfx,
        pk10q4zxfx,
        pk10q3zxfx,
        pk10q2zxfx,
        pk10q1zxfx,
      ];
}
/*
* 
  pk10_q5dwd("pk10_dwd", "定位胆"),
  pk10_q5zxfx("pk10_q5zxfx", "前五直选复选"),
  pk10_q4zxfx("pk10_q4zxfx", "前四直选复选"),
  pk10_q3zxfx("pk10_q3zxfx", "前三直选复选"),
  pk10_q2zxfx("pk10_q2zxfx", "前二直选复选"),
  pk10_q1zxfx("pk10_q1zxfx", "前一直选复选"),
* */
