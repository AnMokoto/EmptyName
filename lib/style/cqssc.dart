import 'style.dart';
import 'package:flutter/foundation.dart';
import 'package:lowlottery/log.dart';
import 'ZuheUtil.dart';
import 'package:lowlottery/conf/LotPlay.dart';

///  重庆时时彩分类
@protected
abstract class _cqssc extends PlayStyle {
  // List<List<int>> data;

  _cqssc({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  int get count => 5;

  @override
  forceTransform(d) {
    if (type.endsWith("zuxhz")) {
      return "${d + 1}";
    }
    return d;
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
}

@protected
@reflector
class cqssc_1xfx extends _cqssc {
  cqssc_1xfx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    return ["万位", "千位", "百位", "十位", "个位"];
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    var count = 0;

    state.code = "";

    List<String> value = new List();
    data.forEach((item) {
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
@reflector
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
    data.forEach((item) {
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
@reflector
class cqssc_q2fx extends _cqssc {
  cqssc_q2fx({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  List<String> initialType() {
    if (type.contains("q2")) {
      return ["万位", "千位"];
    }
    if (type.contains("h2")) {
      return ["十位", "个位"];
    }
    if (type.contains("h3")) {
      return ["百位", "十位", "个位"];
    }
    if (type.contains("q3")) {
      return ["万位", "千位", "百位"];
    }
    if (type.contains("z3")) {
      return ["千位", "白位", "十位"];
    }
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
@reflector
class cqssc_hz extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_hz(
      {String len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    this._zhushu = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
  }

  @override
  int get initialCount => 19;

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
@reflector
class cqssc_zuxfx extends _cqssc {
  @protected
  int len = 0;

  cqssc_zuxfx(
      {int len, @required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
    this.len = len;
  }

  @override
  void playReset() {
    super.playReset();
  }

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
@reflector
class cqssc_zuxhz extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_zuxhz(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type.contains("2"))
      this._zhushu = [1, 1, 2, 2, 3, 3, 4, 4, 5, 4, 4, 3, 3, 2, 2, 1, 1];
  }

  @override
  int get initialCount => 17;

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
        count += this._zhushu[f];
        value.add(forceTransform(f));
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

///前二后二组选包胆
///todo 包胆起始位置从1开始，需要特殊处理，暂时未处理
@protected
@reflector
class cqssc_zuxbd extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_zuxbd(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
  }

//包胆只能选择一位号码
  @override
  List<List<int>> toBet2System(int index, int position) {
    if (position >= data[0].length) return data;
    for (int i = 0; i < data[0].length; ++i) {
      data[0][i] = -1;
    }
    data[0][position] = data[0][position] == -1 ? position : -1;
    return data;
  }

  @override
  PlayModelItem transformWithType(PlayModelItem state) {
    state.code = "";
    List<String> value = new List();
    data[0].forEach((f) {
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
@reflector
class cqssc_bd1 extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_bd1(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

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
@reflector
class cqssc_bd2 extends _cqssc {
  @protected
  List<int> _zhushu;
  int zuheCount = 2;

  cqssc_bd2(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type.endsWith("5xsbd")) {
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
@reflector
class cqssc_kd extends _cqssc {
  @protected
  List<int> _zhushu;

  cqssc_kd(
      {@required String type,
      @required String name,
      String desc,
      String initLeftDesc})
      : super(type: type, name: name, desc: desc);

  @override
  void playReset() {
    // TODO: implement playReset
    super.playReset();
    if (type.contains("2"))
      this._zhushu = [10, 18, 16, 14, 12, 10, 8, 6, 4, 2];
    else if (type.contains("3"))
      this._zhushu = [10, 54, 96, 126, 144, 150, 144, 126, 96, 54];
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
@reflector
class cqssc_hz3 extends cqssc_hz {
  cqssc_hz3({@required String type, @required String name, String desc})
      : super(type: type, name: name, desc: desc) {
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

  @override
  int get initialCount => 28;
}

class Stylessc extends StyleManagerIMPL {
  const Stylessc();

  static List<String> plays = [];
  static Map<String ,List<dynamic>> oddMap = {};
  factory Stylessc.of(String str ,List<String> playEns ,Map<String ,List<dynamic>> oddMap1) {
    plays = playEns;
    oddMap = oddMap1;
    return const Stylessc();
  }

  external factory Stylessc.from();

  @override
  String get name => "重庆时时彩";

  @override
  List<String> playEns() {
    return plays;
  }

  @override
  PlayStyle playStyle(String playEn) {
    PlayStyle playStyle =null;
    switch (playEn) {
      case 'ssc_1xfx':
        playStyle = cqssc_1xfx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_h2zuxbd':
      case 'ssc_q2zuxbd':
        playStyle =cqssc_zuxbd(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_q2zuxbd':
        playStyle= cqssc_hz(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_h2zxhz':
      case 'ssc_q2zxhz':
        playStyle= cqssc_zuxfx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_h2zuxhz':
      case 'ssc_q2zuxhz':
        playStyle= cqssc_zuxhz(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_z3zxkd':
      case 'ssc_q3zxkd':
      case 'ssc_h3zxkd':
      case 'ssc_q2zxkd':
      case 'ssc_h2zxkd':
        playStyle= cqssc_kd(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_z3zxhz':
      case 'ssc_q3zxhz':
      case 'ssc_h3zxhz':
        playStyle= cqssc_hz3(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_z3zxfx':
      case 'ssc_q3zxfx':
      case 'ssc_h3zxfx':
      case 'ssc_h2zxfx':
      case 'ssc_q2zxfx':
        playStyle= cqssc_q2fx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_5xsbd':
      case 'ssc_5xebd':
      case 'ssc_4xebd':
      case 'ssc_z3ebd':
      case 'ssc_h3ebd':
      case 'ssc_q3ebd':
        playStyle= cqssc_bd2(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_5xybd':
      case 'ssc_4xybd':
      case 'ssc_z3ybd':
      case 'ssc_h3ybd':
      case 'ssc_q3ybd':
      case 'ssc_5xybd':
        playStyle= cqssc_bd1(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
      case 'ssc_5xzxfx':
      case 'ssc_4xzxfx':
        playStyle= cqssc_5xzxfx(type: playEn, name: LotPlayConfig.getName(playEn));
        break;
    }
    if(playStyle!=null){
      playStyle.oddsMap = oddMap;
    }
    return playStyle;
  }
}
