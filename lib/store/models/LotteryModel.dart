library lotteryModel;

import 'package:json_annotation/json_annotation.dart';

part 'LotteryModel.g.dart';

@JsonSerializable()
class Lottery extends Object with _$LotterySerializerMixin {
  var gameEn; //彩种编码
  var openTime; //开奖时间
  var opencode; //开奖号码
  var expectNo; //期号数据

  factory Lottery.fromJson(Map<String, dynamic> json) =>
      _$LotteryFromJson(json);

  static List<Lottery> fromJsonToList(List<dynamic> json) {
    List<Lottery> list = new List();
    json.forEach((f) {
      try {
        list.add(Lottery.fromJson(f));
      } catch (e) {
        print(e);
      }
    });
    return list;
  }

  Lottery(this.gameEn, this.openTime, this.opencode, this.expectNo);
}

@JsonSerializable()
class LotteryModel extends Lottery with _$LotteryModelSerializerMixin {
  // {
  //   "gameEn": "cqssc",
  //   "expectNo": "20180812080",
  //   "createTime": 1533983570513,
  //   "updateTime": 1533983570513,
  //   "startTime": 1534072200000,
  //   "endTime": 1534072800000,
  //   "buyStartTime": 1534072200000,
  //   "buyEndTime": 1534072795000,
  //   "opencode": null,
  //   "openTime": null,
  //   "nowTime": 1534072380530,
  //   "remainTime": 414470
  // }
  var buyEndTime; //购买截止时间
  var remainTime; //倒计时时长
  var buyStartTime;

  factory LotteryModel.fromJson(Map<String, dynamic> json) =>
      _$LotteryModelFromJson(json);

  LotteryModel(var gameEn, var openTime, var opencode, var expectNo,
      this.buyStartTime, this.buyEndTime, this.remainTime)
      : super(gameEn, openTime, opencode, expectNo);
}

class LotteryState {
  /// 当前记录信息 remainTime
  LotteryModel lottery;

  /// 历史记录
  List<Lottery> history;
}

class LotteryRecord {
  List<dynamic> data;
  Map<String, dynamic> detail;
}
