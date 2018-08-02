library RefreshLayer;

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// if [up] is true, refreshing, or load more.
typedef OnRefresh(bool up);
typedef Widget IndicatorBuilder(BuildContext context, int mode);

class RefreshLayer extends StatelessWidget {
  SmartRefresher refresher;

  RefreshLayer(
      {Key key,
      IndicatorBuilder header,
      IndicatorBuilder footer,
      bool enablePullUp, // load more
      bool enablePullDown = true, // refresh
      @required ScrollView child,
      @required OnRefresh refresh})
      : super(key: key) {
    refresher = new SmartRefresher(
      child: child,
      onRefresh: refresh,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      headerBuilder: header,
      footerBuilder: footer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return refresher;
  }
}
