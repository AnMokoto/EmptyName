import 'package:flutter/material.dart';

import 'package:lowlottery/m/goodslist.dart';

class ItemViewIndex extends StatefulWidget {
  const ItemViewIndex({this.good}) : assert(good != null);

  final GoodsList good;

  State<ItemViewIndex> createState() => new ItemViewIndexState();
}

class ItemViewIndexState extends State<ItemViewIndex> {
  @override
  Widget build(BuildContext context) {
    var commission = widget.good.commission;
    var sourPrice = widget.good.sourPrice;
    var wlPrice = widget.good.wlPrice;
    var coupon = widget.good.coupon;

    return new Column(
      children: <Widget>[
        new Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            new Image.network(
              widget.good.imgUrl,
              fit: BoxFit.fitWidth,
            ),
            new Container(
              decoration: new BoxDecoration(color: Colors.red),
              alignment: Alignment.bottomCenter,
              child: new Text(
                "预估购买赚¥$commission",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        new Container(
          color: Colors.white,
          padding: EdgeInsets.all(2.0),
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Text(
                  // "dddd",
                  widget.good.skuName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text(
                      widget.good.source,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  new Text(
                    widget.good.baoyou == 1 ? "包邮" : "",
                    textDirection: TextDirection.rtl,
                  )
                ],
              ),
              new Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "原价¥$sourPrice",
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text("¥$wlPrice",
                        style: new TextStyle(
                          color: Colors.red[400],
                        )),
                  ),
                  new Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    child: new Text(
                      "$coupon元劵",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
