import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    this._price = price;
    playReset();
  }

  @protected
  PlayModelItem model;

  /// 需要结算的数据
  /// 返回传递参数信息
  PlayModelItem get transform => transformWithType(this.model);

  PlayModelItem randomType() {
    /// 随机生成
  }

  /// 重置选项卡数据
  @mustCallSuper
  void playReset() {
    model = new PlayModelItem()..playEn = this.type;
  }

  /// 当前选项是否为可激活状态
  bool isValid() => model != null && model.zhushu > 0 && model.money > 0;

  /// 业务处理，不对外
  @protected
  PlayModelItem transformWithType(PlayModelItem model);

  /// 列表描述
  /// 列表前缀
  @protected
  List<String> initialType();

  /// 返回初始化需要的信息
  /// 样式为 `[[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]]` -1即未选中
  /// 前台默认取数据展示就行，不做这块的数据处理
  @protected
  List<List<int>> initialArray();

  /// 交互操作，对 [initialArray] 的数据进行操作
  /// [index] 列数
  /// [position]  选中的号码
  /// return 返回数据需要显示的格式
  List<List<int>> toBet2System(int index, int position);

//////////////// //////// //////// ////////    布局相关 //////// //////// //////// //////// //////// //////// ////////

  /// 强制转换数据显示
  @protected
  dynamic forceTransform(dynamic d) => d;

  /// 当前期号显示个数
  /// return int
  int get count;

  /// 显示列数相关信息
  LotteryStyle get layerStyle => new LotteryStyleDefault();

  /// 默认返回左侧广告牌
  Widget billboard(int position) {
    final type = initialType();
    if (type == null || type.isEmpty || type[position] == "") return null;
    return new Container(
      width: 50.0,
      height: 30.0,
      decoration: new BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: new Center(
        child: new Text(
          type[position] ?? "",
          style: new TextStyle(
            color: Colors.black26,
            fontSize: 13.0,
          ),
          maxLines: 1,
        ),
      ),
      margin: EdgeInsets.only(right: 20.0),
    );
  }

  /// 返回背景
  /// [position] && [index] 预留 定向item配色传递
  @protected
  Shape shape(int position, int index) {
    return new ShapeCircle();
  }

  /// 返回控件空间
  @protected
  BoxConstraints get constraints =>
      new BoxConstraints(minHeight: 35.0, minWidth: 35.0);

  /// 返回需要展示的Item
  /// [position] => [initialArray]
  List<Widget> generate(int position, fun(int p, int i)) {
    final data = initialArray()[position];
    return new List.generate(data.length, (index) {
      final isSelect = data[index] != -1;
      return new InkWell(
          child: new StyleGenerateItem(
            shape: shape(position, index),
            constraints: constraints,
            isSelect: isSelect,
            child: getChildItem(position, index),
          ),
          onTap: () {
            fun(position, index);
          });
    });
  }

  ///  返回单个布局样式
  /// 可以不重写这个方法，默认返回
  /// [position] 当前item
  /// [index] item inside
  /// 重写 [generate]后这个方法可以省略
  @protected
  Widget getChildItem(int position, int index) {
    final data = initialArray()[position];
    final isSelect = data[index] != -1;
    return new Center(
      child: new Text(
        "${forceTransform(index)}",
        maxLines: 1,
        style: new TextStyle(
            color: isSelect ? Colors.white : Colors.red, fontSize: 17.0),
      ),
    );
  }
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
      type.contains("thdx") ||
      type.contains("2thfx") ||
      type.contains("2bth")) {
    return transformToWithOutPoint(choice);
  }
  if (type.contains("xglhc")) {
    /*if (
        type.contains("zmz1t") ||
        type.contains("zmz2t") ||
        type.contains("zmz3t") ||
        type.contains("zmz4t") ||
        type.contains("zmz5t") ||
        type.contains("zmz6t") ||
        type.endsWith("lm") || //两面
        type.contains("bz")
        ) {*/
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

abstract class LotteryStyle {
  /// 当前样式返回的一行最大显示数
  int get maxLineCount;
}

class LotteryStyleDefault extends LotteryStyle {
  final int count;

  LotteryStyleDefault({this.count = 5});

  int get maxLineCount => count;
}

abstract class Shape {
  /// 获取背景样式
  Decoration get decoration;
  Decoration get onPressDecoration;
}

class ShapeCircle extends Shape {
  @override
  // TODO: implement decoration
  Decoration get decoration =>
      new BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle);

  @override
  Decoration get onPressDecoration =>
      new BoxDecoration(color: Colors.red, shape: BoxShape.circle);
}

class StyleGenerateItem extends StatelessWidget {
  bool isSelect;
  Widget child;
  Decoration shape;
  BoxConstraints constraints;

  StyleGenerateItem(
      {this.isSelect = false,
      @required this.child,
      @required Shape shape,
      this.constraints,
      Key key})
      : assert(child != null && shape != null),
        super(key: key) {
    this.shape = isSelect ? shape.onPressDecoration : shape.decoration;
    this.constraints =
        constraints ?? new BoxConstraints(minHeight: 35.0, minWidth: 35.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(left: 1.0, right: 1.0),
        constraints: constraints,
        alignment: Alignment.center,
        decoration: shape,
        child: child);
  }
}
