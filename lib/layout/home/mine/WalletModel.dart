library lotteryModel;

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Wallet extends Object {
  var gameEn; //彩种编码
  var openTime; //开奖时间
  var opencode; //开奖号码
  var expectNo; //期号数据
  var buyEndTime; //购买截止时间
  var remainTime; //倒计时时长

  Wallet(this.gameEn, this.openTime, this.opencode, this.expectNo);
}
