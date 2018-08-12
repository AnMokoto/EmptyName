library lotteryModel;

import 'package:json_annotation/json_annotation.dart';

part 'LotteryModel.g.dart';

@JsonSerializable()
class Lottery extends Object with _$LotterySerializerMixin {
  var gameEn;
  var openTime;
  var opencode;
  var expectNo;

  factory Lottery.fromJson(Map<String, dynamic> json) =>
      _$LotteryFromJson(json);

  static List<Lottery> fromJsonToList(List<dynamic> json) {
    List<Lottery> list = new List();
    json.forEach((f) {
      try {
        list.add(Lottery.fromJson(f));
      } on Exception {}
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

  var remainTime;
  var buyStartTime;
  var buyEndTime;

  factory LotteryModel.fromJson(Map<String, dynamic> json) =>
      _$LotteryModelFromJson(json);

  LotteryModel(var gameEn, var openTime, var opencode, var expectNo,
      this.buyStartTime, this.buyEndTime, this.remainTime)
      : super(gameEn, openTime, opencode, expectNo);
}
