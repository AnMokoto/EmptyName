import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/common/mvp.dart';
import 'IndexContract.dart';
import 'package:lowlottery/widget/fixbox/FixBoxWidget.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:lowlottery/layout/lottery/LotteryLayer.dart';

class IndexFragLayer extends StatefulWidget {
  List<FixBoxModel> models;

  IndexFragLayer({Key key}) : super(key: key) {
    this.models = List.generate(6, (index) {
      return new FixBoxModel(
          id: index, name: "$index", url: "assets/images/move.png");
    });
  }

  @override
  _IndexFragState createState() =>
      new _IndexFragState(new IndexFragPresenter());
}

class _IndexFragState extends MVPState<IndexFragPresenter, IndexFragLayer>
    implements IndexFragIView {
  _IndexFragState(IndexFragPresenter presenter) : super(presenter);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //presenter.requestIndexFragLottery();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: Image.asset(
            "assets/images/app_back.png",
            fit: BoxFit.cover,
          ),
        ), //banner
        new Align(
          alignment: Alignment.centerLeft,
          child: new Directionality(
            textDirection: TextDirection.ltr,
            child: new Text(
              "data",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.left,
              style: new TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        new Expanded(
            child: new FixBoxWidget(
                models: widget.models,
                onItemClick: (model, position) {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new LotteryLayer()));
                }))
      ],
    );
  }
}
