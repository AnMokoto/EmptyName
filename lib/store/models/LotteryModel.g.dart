// GENERATED CODE - DO NOT MODIFY BY HAND

part of lotteryModel;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Lottery _$LotteryFromJson(Map<String, dynamic> json) => new Lottery(
    json['gameEn'], json['openTime'], json['opencode'], json['expectNo']);

abstract class _$LotterySerializerMixin {
  dynamic get gameEn;
  dynamic get openTime;
  dynamic get opencode;
  dynamic get expectNo;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'gameEn': gameEn,
        'openTime': openTime,
        'opencode': opencode,
        'expectNo': expectNo
      };
}

LotteryModel _$LotteryModelFromJson(Map<String, dynamic> json) =>
    new LotteryModel(
        json['gameEn'],
        json['openTime'],
        json['opencode'],
        json['expectNo'],
        json['buyStartTime'],
        json['buyEndTime'],
        json['remainTime']);

abstract class _$LotteryModelSerializerMixin {
  dynamic get gameEn;
  dynamic get openTime;
  dynamic get opencode;
  dynamic get expectNo;
  dynamic get remainTime;
  dynamic get buyStartTime;
  dynamic get buyEndTime;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'gameEn': gameEn,
        'openTime': openTime,
        'opencode': opencode,
        'expectNo': expectNo,
        'remainTime': remainTime,
        'buyStartTime': buyStartTime,
        'buyEndTime': buyEndTime
      };
}
