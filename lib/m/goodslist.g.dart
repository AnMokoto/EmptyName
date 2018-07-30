// GENERATED CODE - DO NOT MODIFY BY HAND

part of goodslist;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

GoodsList _$GoodsListFromJson(Map<String, dynamic> json) => new GoodsList(
    coupon: json['coupon'],
    wlPrice: json['wlPrice'],
    sourPrice: json['sourPrice'],
    skuId: json['skuId'],
    link: json['link'],
    source: json['source'],
    sub_type: json['sub_type'],
    baoyou: json['baoyou'],
    commission: json['commission'],
    imgUrl: json['imgUrl'],
    skuName: json['skuName'],
    id: json['id']);

abstract class _$GoodsListSerializerMixin {
  dynamic get coupon;
  dynamic get wlPrice;
  dynamic get sourPrice;
  dynamic get skuId;
  dynamic get link;
  dynamic get source;
  dynamic get sub_type;
  dynamic get baoyou;
  dynamic get commission;
  dynamic get imgUrl;
  dynamic get skuName;
  dynamic get id;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'coupon': coupon,
        'wlPrice': wlPrice,
        'sourPrice': sourPrice,
        'skuId': skuId,
        'link': link,
        'source': source,
        'sub_type': sub_type,
        'baoyou': baoyou,
        'commission': commission,
        'imgUrl': imgUrl,
        'skuName': skuName,
        'id': id
      };
}
