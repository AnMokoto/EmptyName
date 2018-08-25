import 'package:flutter/foundation.dart';
/////////
/// @author An'Mokoto
/// [bet] 下注的数字 [0,1,-,-,-] 共计 五位
/// 其中 `Value` 每一位置区间长度`(0-10]`, 长度为 `-` 时表示 `0`
/// @desc 玩法 注数 x 单注价格 x 倍数 = Total
//////// 一下数据为用户选择的数据

// {
// expectNo (string): 当前期号 ,
// gameEn (string): 彩种编码 ,
// money (number): 方案总金额 ,
// zhushu (integer): 方案总注数 ,
// content (Array[ProjectContent])
// }
/// 传递类型
class PlayModel extends Object {
  String gameEn;
  String expectNo;
  String money;
  int zhushu;
  double beishu;
  List<PlayModelItem> content;
  PlayModel({
    this.beishu: 1.0,
  }) {
    this.content = new List();
  }

  Map<String, dynamic> toMap() {
    return {
      "gameEn": gameEn,
      "expectNo": expectNo,
      "money": money,
      "beishu": beishu,
      "zhushu": zhushu,
      "content": content.map((f) => f.toMap()).toList()
    };
  }
}

// {
// beishu (integer): 倍数 ,
// code (string): 当前用户选号 ,
// money (number): 购彩金额 ,
// playEn (string): 玩法编码 ,
// zhushu (integer): 购彩注数
// }
/// 选中类型
class PlayModelItem extends Object {
  String code;
  String playEn;
  int zhushu;
  double money;

  PlayModelItem({this.code, this.playEn: "", this.zhushu: 0, this.money: 0.0});

  Map<String, dynamic> toMap() {
    return {
      "code": code,
      //"code":code.toString(),

      "playEn": playEn,
      "zhushu": zhushu,
      "money": money
    };
  }
}

/// 对玩法数据实际操作的工具类
abstract class PlayStyle {
  /// 玩法样式
  @protected
  String _type;
  String get type => _type;

  /// 玩法描述
  @protected
  String _desc;
  String get desc => _desc;

  /// 显示名称
  @protected
  String _showName;
  String get name => _showName;

  ///默认一注好多钱
  @protected
  double _price;
  double get price => _price;

  @protected
  PlayStyle(
      {@required String type,
      @required String name,
      String desc,
      double price: 2.0})
      : assert(type != null),
        assert(name != null) {
    this._type = type;
    this._showName = name;
    this._desc = desc ?? "";
    this.model = new PlayModelItem()..playEn = type;
    this._price = price;
  }

  @protected
  PlayModelItem model;

  /// 需要结算的数据
  /// 返回传递参数信息
  PlayModelItem get transform => transformWithType(this.model);

  /// 业务处理，不对外
  @protected
  PlayModelItem transformWithType(PlayModelItem model);

  /// 当前期号显示个数
  /// return int
  int get count;

  /// 强制转换数据显示
  dynamic forceTransform(dynamic d);

  /// 列表描述
  /// 列表前缀
  List<String> initialType();

  /// 返回初始化需要的信息
  /// 样式为 `[[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]]` -1即未选中
  /// 前台默认取数据展示就行，不做这块的数据处理
  List<List<int>> initialArray();

  /// 交互操作，对 [initialArray] 的数据进行操作
  /// [index] 列数
  /// [position]  选中的号码
  /// return 返回数据需要显示的格式
  List<List<int>> toBet2System(int index, int position);
}

/// 替换数据格式
String transformToString(List<dynamic> choice, String type) {
  List<String> contains = ["zuxfx", "zuxhz", "zuxkd"];
  if (type.endsWith("hz") ||
      type.endsWith("kd") ||
      type.endsWith("zuxfx") ||
      type.contains("zuxhz") ||
      type.contains("zuxkd") ||
      type.endsWith("ybd") ||
      type.endsWith("ebd") ||
      type.endsWith("sbd") ||
      type.contains("zuxbd")) {
    return transformToWithOutPoint(choice);
  }
  return choice.toString().replaceAll(new RegExp(r"(\]|\[)"), "");
}

/// 替换数据格式
/// 带逗号分割
String transformToWithPoint(List<dynamic> choice) {
  String code;

  if (choice.isEmpty) {
    code = "-";
  } else {
    code = choice
        .toString()
        .replaceAll(new RegExp(r"(\]|\[)"), "")
        .replaceAll(",", "");
  }
  return code;
}

/// 替换数据格式
/// 不带逗号分割
String transformToWithOutPoint(List<dynamic> choice) {
  String code =
      transformToWithPoint(choice).replaceAll("-", "").replaceAll(",", "");

  return code;
}

/// 彩种控制
abstract class StyleManagerIMPL {
  const StyleManagerIMPL();

  /// 返回当前彩种的所有玩法
  List<PlayStyle> get all;

  String get name;
}

// class style {
//   factory style.cqssc_1xfx() => style(type: "1xfx", desc: "1星复选");
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
//   factory style.cqssc_h2zxkd() => style(type: "h2zxkd", desc: "后二直选跨度");
//   factory style.cqssc_h2zuxfx() => style(type: "h2zuxfx", desc: "后二组选复选");
//   factory style.cqssc_h2zuxhz() => style(type: "h2zuxhz", desc: "后二组选和值");
//   factory style.cqssc_h2zuxbd() => style(type: "h2zuxbd", desc: "后二组选包胆");
//   //前三
//   factory style.cqssc_q3zxfx() => style(type: "q3zxfx", desc: "前三直选复选");
//   factory style.cqssc_q3zxhz() => style(type: "q3zxhz", desc: "前三直选和值");
//   factory style.cqssc_q3zxkd() => style(type: "q3zxkd", desc: "前三直选跨度");
//   factory style.cqssc_q3ybd() => style(type: "q3ybd", desc: "前三一码不定位");
//   factory style.cqssc_q3ebd() => style(type: "q3ebd", desc: "前三二码不定位");

//   //后三
//   factory style.cqssc_h3zxfx() => style(type: "h3zxfx", desc: "后三直选复选");
//   factory style.cqssc_h3zxhz() => style(type: "h3zxhz", desc: "后三直选和值");
//   factory style.cqssc_h3zxkd() => style(type: "h3zxkd", desc: "后三直选跨度");
//   factory style.cqssc_h3ybd() => style(type: "h3ybd", desc: "后三一码不定位");
//   factory style.cqssc_h3ebd() => style(type: "h3ebd", desc: "后三二码不定位");
//   //后三
//   factory style.cqssc_z3zxfx() => style(type: "z3zxfx", desc: "中三直选复选");
//   factory style.cqssc_z3zxhz() => style(type: "z3zxhz", desc: "中三直选和值");
//   factory style.cqssc_z3zxkd() => style(type: "z3zxkd", desc: "中三直选跨度");
//   factory style.cqssc_z3ybd() => style(type: "z3ybd", desc: "中三一码不定位");
//   factory style.cqssc_z3ebd() => style(type: "z3ebd", desc: "中三二码不定位");
//   //四星
//   factory style.cqssc_4xzxfx() => style(type: "4xzxfx", desc: "四星直选复选");
//   factory style.cqssc_4xybd() => style(type: "4xybd", desc: "四星一码不定位");
//   factory style.cqssc_4xebd() => style(type: "4xebd", desc: "四星二码不定位");

//   //五星
//   factory style.cqssc_5xzxfx() => style(type: "5xzxfx", desc: "五星直选复选");
//   factory style.cqssc_5xybd() => style(type: "5xybd", desc: "五星一码不定位");
//   factory style.cqssc_5xebd() => style(type: "5xebd", desc: "五星二码不定位");
//   factory style.cqssc_5xsbd() => style(type: "5xsbd", desc: "五星三码不定位");
//   //大小���双
//   factory style.cqssc_q2dxds() => style(type: "q2dxds", desc: "前二大小单双");
//   factory style.cqssc_h2dxds() => style(type: "h2dxds", desc: "后二大小单双");
//   factory style.cqssc_q3dxds() => style(type: "q3dxds", desc: "前三大小单双");
//   factory style.cqssc_h3dxds() => style(type: "h3dxds", desc: "后三大小单双");

//   //北京pk10
//   factory style.pk10_q5zxfx() => style(type: "q5zxfx", desc: "前五直选复选");
//   factory style.pk10_q4zxfx() => style(type: "q4zxfx", desc: "前四直选复选");
//   factory style.pk10_q3zxfx() => style(type: "q3zxfx", desc: "前三��选复选");
//   factory style.pk10_q2zxfx() => style(type: "q2zxfx", desc: "前二直选复选");
//   factory style.pk10_q1zxfx() => style(type: "q1zxfx", desc: "前一直选复选");

//   //广东快乐10分
//   factory style.gdkl10_rx2() => style(type: "rx2", desc: "任选二");
//   factory style.gdkl10_rx3() => style(type: "rx3", desc: "任选三");
//   factory style.gdkl10_rx4() => style(type: "rx4", desc: "任选四");
//   factory style.gdkl10_rx5() => style(type: "rx5", desc: "任选五");
//   factory style.gdkl10_rx6() => style(type: "rx6", desc: "任选六");
//   factory style.gdkl10_rx7() => style(type: "rx7", desc: "任选七");
//   factory style.gdkl10_rx8() => style(type: "rx8", desc: "任��八");
//   factory style.gdkl10_q1zxfx() => style(type: "q1zxfx", desc: "前一直选复选");
//   factory style.gdkl10_q2zxfx() => style(type: "q2zxfx", desc: "前二直选复选");
//   factory style.gdkl10_q3zxfx() => style(type: "q3zxfx", desc: "前三直选复选");
//   factory style.gdkl10_q2zuxfx() => style(type: "q2zuxfx", desc: "前���组选复选");
//   factory style.gdkl10_q3zuxfx() => style(type: "q3zuxfx", desc: "前三组选复选");

//   //广西快三
//   factory style.gxk3_hz() => style(type: "hz", desc: "和值");
//   factory style.gxk3_3thdx() => style(type: "3thdx", desc: "三同号单选");
//   factory style.gxk3_3bth() => style(type: "3bth", desc: "三不同号");
//   factory style.gxk3_2thfx() => style(type: "2thfx", desc: "二同号复选");
//   factory style.gxk3_2thdx() => style(type: "2thdx", desc: "二同号单选");
//   factory style.gxk3_2bt() => style(type: "2bt", desc: "二不同号");
//   factory style.gxk3_3thtx() => style(type: "3thtx", desc: "三同号通选");
//   factory style.gxk3_3lhtx() => style(type: "3lhtx", desc: "三连号通选");

//   //广东11选5
//   factory style.gd11x5_rx2() => style(type: "rx2", desc: "任���二");
//   factory style.gd11x5_rx3() => style(type: "rx3", desc: "任选三");
//   factory style.gd11x5_rx4() => style(type: "rx4", desc: "任选四");
//   factory style.gd11x5_rx5() => style(type: "rx5", desc: "任���五");
//   factory style.gd11x5_rx6() => style(type: "rx6", desc: "任选��");
//   factory style.gd11x5_rx7() => style(type: "rx7", desc: "任���七");
//   factory style.gd11x5_q1zxfx() => style(type: "q1zxfx", desc: "前一直选复选");
//   factory style.gd11x5_rx8() => style(type: "rx8", desc: "任选八");
//   factory style.gd11x5_q2zxfx() => style(type: "q2zxfx", desc: "前二直选复选");
//   factory style.gd11x5_q3zxfx() => style(type: "q3zxfx", desc: "前三直选复选");
//   factory style.gd11x5_q2zuxfx() => style(type: "q2zuxfx", desc: "前二组选复选");

//   factory style.gd11x5_q3zuxfx() => style(type: "q3zuxfx", desc: "前三组选复选");

//   //  香港六合彩特码
//   factory style.xglhc_tmlm() => style(type: "tmlm", desc: "特码两面");
//   factory style.xglhc_tmzx() => style(type: "tmzx", desc: "特码直选");
//   //香港六合彩正码
//   factory style.xglhc_zmrx() => style(type: "rxzm", desc: "正码任选");
//   factory style.xglhc_zmz1t() => style(type: "rxzm", desc: "正码正1特");
//   factory style.xglhc_zmz1lm() => style(type: "rxzm", desc: "正码正1两面");
//   factory style.xglhc_zmz2t() => style(type: "rxzm", desc: "正码正2特");
//   factory style.xglhc_zmz2lm() => style(type: "rxzm", desc: "正码正2两面");
//   factory style.xglhc_zmz3t() => style(type: "rxzm", desc: "正码正3特");
//   factory style.xglhc_zmz3lm() => style(type: "rxzm", desc: "正码正3两面");
//   factory style.xglhc_zmz4t() => style(type: "rxzm", desc: "正码正4特");
//   factory style.xglhc_zmz4lm() => style(type: "rxzm", desc: "正码正4两面");
//   factory style.xglhc_zmz5t() => style(type: "rxzm", desc: "正码正5特");
//   factory style.xglhc_zmz5lm() => style(type: "rxzm", desc: "��码正5两面");
//   factory style.xglhc_zmz6t() => style(type: "rxzm", desc: "正码正6特");
//   factory style.xglhc_zmz6lm() => style(type: "rxzm", desc: "正码正6两面");
// }
