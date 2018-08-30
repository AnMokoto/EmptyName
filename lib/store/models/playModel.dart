library app.store.models.play;

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

  factory PlayModelItem.copy(PlayModelItem item) {
    return new PlayModelItem(
        code: item.code,
        playEn: item.playEn,
        zhushu: item.zhushu,
        money: item.money);
  }
}
