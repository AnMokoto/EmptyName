import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'LotteryContract.dart';

class LotteryLayer extends StatefulWidget {
  @override
  _LotteryState createState() => new _LotteryState(new LotteryPresenter());
}

class _LotteryState extends MVPState<LotteryPresenter, LotteryLayer> {
  _LotteryState(LotteryPresenter presenter) : super(presenter);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ,
    );
  }
}
