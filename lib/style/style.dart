import 'package:flutter/foundation.dart';
import 'package:lowlottery/conf/BuyLotLineHeight.dart';
import 'package:lowlottery/store/models/playModel.dart';
export 'package:lowlottery/store/models/playModel.dart';

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

  @protected
  double _height;
  double get height => _height;

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
    this._height = LotLineHeight.calHeight("", type);
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
  dynamic forceTransform(dynamic d) => d;

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
      type.contains("zuxbd") ||
      type.contains("rx") ||
      type.contains("zmz1t") ||
      type.contains("zmz2t") ||
      type.contains("zmz3t") ||
      type.contains("zmz4t") ||
      type.contains("zmz5t") ||
      type.contains("zmz6t")) {
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
