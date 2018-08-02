import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'IndexContract.dart';
import 'package:lowlottery/widget/fixbox/FixBoxWidget.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

class IndexFragLayer extends StatefulWidget implements IndexFragIView {
  List<FixBoxModel> models;

  IndexFragLayer({Key key}) : super(key: key) {
    models = new List();
  }

  @override
  _IndexFragState createState() =>
      new _IndexFragState(new IndexFragPresenter(this));
}

class _IndexFragState extends MVPState<IndexFragPresenter, IndexFragLayer> {
  _IndexFragState(IndexFragPresenter presenter) : super(presenter);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter.
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: Image.asset(
            "app_back.png",
            fit: BoxFit.cover,
          ),
        ), //banner
        new Expanded(
            child: new FixBoxWidget(
          models: widget.models,
        ))
      ],
    );
  }
}
