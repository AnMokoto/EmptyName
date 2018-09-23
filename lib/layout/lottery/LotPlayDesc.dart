import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/layout/bet/LotteryBetLayer.dart';
import 'package:lowlottery/store/appStore.dart';
import 'package:lowlottery/style/index.dart';

import 'dart:async';
import 'dart:io';

import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/conf/date.dart';
import 'package:lowlottery/widget/Lottery2Layer.dart';
import 'package:lowlottery/conf/Lot.dart';
import 'package:lowlottery/layout/pops/LotplayDetailPop.dart';

/// callback when who preclick the item.
/// [position] item count position
/// [index] inline index
typedef void OnLotteryPushClick(int position, int index);

class LotteryHeadSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  String playEn;
  Map<String, List<dynamic>> oddsMap;
  Store<AppState> state;

  String desc;

  LotteryHeadSliverPersistentHeaderDelegate({this.playEn ,this.oddsMap}) {}

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SafeArea(
      child: new Semantics(
        child: new StoreConnector<AppState, List<dynamic>>(
            builder: (context, state) {
          var m = new Map();
          Map val =
              state.firstWhere((e) => e['playEn'] == playEn, orElse: () => m);
          if (val.length > 0) {
            List<dynamic> odds = [];
            if (oddsMap != null && oddsMap.isNotEmpty) {
              odds = oddsMap[playEn];

            }
            return new InkWell(
                onTap: () {
                  print('show detail');
                  LotPlayDetailPop.lotPlayDetail(
                      context, '玩法描述', '${val["desc"]}' ,odds);
                },
                child: new Container(
                  child: new Column(children: <Widget>[
                    new Container(
                      child: new Text(
                        "${val['shortDesc']} ",
                        style: new TextStyle(color: Colors.grey),
                      ),
                    ),
                  ]),
                ));
          }
          return new Text("");
        }, converter: (state) {
          var content = state.state.lotplayModel.list;
          return content;
        }),
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 0.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
