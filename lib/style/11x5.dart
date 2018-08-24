import 'style.dart';
import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';
import 'ZuheUtil.dart';
///  重庆时时彩分类
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
}

@protected
class cqssc_1xfx extends _11x5 {
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
class cqssc_5xzxfx extends _11x5 {
  cqssc_5xzxfx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    if(type.endsWith("5xzxfx"))
    return ["万位", "千位" ,"百位" ,"十位" ,"个位"];
    else if(type.endsWith("4xzxfx")) {
    return ["千位" ,"百位" ,"十位" ,"个位"];
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
class cqssc_q2fx extends _11x5 {
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
class cqssc_hz extends _11x5 {
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
class cqssc_zuxfx extends _11x5 {
  @protected
  int len =0;
  cqssc_zuxfx(
      {int len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
    this.len = len ;
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

    var count = ZuheUtil.combination(value.length,len );
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
class cqssc_zuxhz extends _11x5 {
  @protected
  List<int> _zhushu;

  cqssc_zuxhz(
      {  @required String type, @required String name, String desc ,String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(17);
    if(type.contains("2"))
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
    Log.message("${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
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
class cqssc_zuxbd extends _11x5 {
  @protected
  List<int> _zhushu;

  cqssc_zuxbd(
      {  @required String type, @required String name, String desc ,String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    //todo 包胆起始位置从1开始，需要特殊处理，暂时未处理
    this._data = initialData(10);

  }
//包胆只能选择一位号码
  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= _data[0].length) return _data;
    for(int i=0;i<_data[0].length;++i){
      _data[0][i]=-1;
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
    Log.message("${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
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
class cqssc_bd1 extends _11x5 {
  @protected
  List<int> _zhushu;

  cqssc_bd1(
      {  @required String type, @required String name, String desc ,String initLeftDesc})
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
    Log.message("${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
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
class cqssc_bd2 extends _11x5 {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;
  cqssc_bd2(
      { @required String type, @required String name, String desc ,String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
    if(type.endsWith("5xsbd")){
      zuheCount = 3 ;
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
    var com = ZuheUtil.combination(value.length, zuheCount) ;
    state.zhushu = com.toInt();
    state.money = state.zhushu * price;

    String code = transformToString(value, type);
    Log.message("${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
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
class cqssc_kd extends _11x5 {
  @protected
  List<int> _zhushu;

  cqssc_kd(
      {  @required String type, @required String name, String desc ,String initLeftDesc})
      : super(type: type, name: name, desc: desc) {
    this._data = initialData(10);
    if(type.contains("2"))
    this._zhushu = [10, 18, 16, 14, 12, 10, 8, 6, 4, 2];
    else if(type.contains("3"))
    this._zhushu = [10, 54, 96, 126, 144, 150, 144, 126,96, 54];

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
    Log.message("${type}_value===$code  shushu:${state.zhushu} money:${state.money}");
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

class Style11x5 extends StyleManagerIMPL {
  const Style11x5();

  factory Style11x5.of(String str) {
    return   const Style11x5();
//    return   const Style();
  }

  PlayStyle get gd11x5rx2 =>
      cqssc_q2fx(type: "q2zxfx", name: "任选二", desc: "任选二");

  @override
  String get name => "十一选五";

  @override
  List<PlayStyle> get all => [
         gd11x5rx2 ,
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