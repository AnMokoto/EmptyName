library goodslist;

import 'package:json_annotation/json_annotation.dart';

part 'goodslist.g.dart';

@JsonSerializable()
class GoodsList extends Object with _$GoodsListSerializerMixin {
  GoodsList({
    this.coupon,
    this.wlPrice,
    this.sourPrice,
    this.skuId,
    this.link,
    this.source,
    this.sub_type,
    this.baoyou,
    this.commission,
    this.imgUrl,
    this.skuName,
    this.id,
  });

  factory GoodsList.fromJson(Map<String, dynamic> json) =>
      _$GoodsListFromJson(json);

  ///优惠帣
  var coupon;

  ///现价
  var wlPrice;

  ///原价
  var sourPrice;
  var skuId;
  var link;

  ///商品来源
  var source;
  var sub_type;

  ///是否包邮
  var baoyou;

  ///佣金
  var commission;

  ///图片地址
  var imgUrl;
  var skuName;
  var id;

  static List<GoodsList> fromJsonToList(List<dynamic> json) {
    List<GoodsList> list = new List();
    for (var str in json) {
      list.add(GoodsList.fromJson(str));
    }
    return list;
  }
}
