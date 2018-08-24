library FixBoxWidget;

import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:lowlottery/font/index.dart';

typedef void OnFixBoxOnItemClick(FixBoxModel model, int position);

/// @auther An'Mokoto
/// @desc item to show container
@immutable
class FixBoxWidget extends StatefulWidget {
  final int count;
  final Axis direction;

  List<FixBoxModel> models;
  OnFixBoxOnItemClick _onItemClick;

  FixBoxWidget(
      {Key key,
      this.count = 3,
      this.direction = Axis.vertical,
      @required this.models,
      OnFixBoxOnItemClick onItemClick})
      : assert(models != null),
        super(key: key) {
    this._onItemClick = onItemClick ?? (context, model, position) {};
  }

  @override
  FixBoxState createState() => new FixBoxState();
}

class FixBoxState extends State<FixBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      shrinkWrap: false,
      crossAxisCount: widget.count,
      scrollDirection: widget.direction,
      children: new List.generate(widget.models.length, (index) {
        return new FixBoxWidgetItem(
            model: widget.models[index],
            position: index,
            onItemClick: widget._onItemClick);
      }),
      padding: const EdgeInsets.all(5.0),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    );
  }
}

class FixBoxWidgetItem extends StatefulWidget {
  final FixBoxModel model;
  final OnFixBoxOnItemClick onItemClick;
  final int position;
  @override
  FixBoxWidgetItemState createState() => new FixBoxWidgetItemState();

  FixBoxWidgetItem(
      {Key key,
      @required this.model,
      @required this.position,
      @required this.onItemClick})
      : assert(model != null),
        super(key: key);
}

class FixBoxWidgetItemState extends State<FixBoxWidgetItem> {
  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.contain,
      alignment: AlignmentDirectional.center,
      child: new InkWell(
        onTap: () {
          widget.onItemClick(widget.model, widget.position);
        },
        child: new Column(
          children: <Widget>[
            new Container(
              constraints: BoxConstraints(
                maxHeight: 70.0,
                minWidth: 70.0,
                minHeight: 70.0,
                maxWidth: 70.0,
              ),
              padding: EdgeInsets.all(10.0),
              child: new FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(AppIcons.fromStr(widget.model.gameEn),color: Colors.red,)),
            ),
            Text(
              widget.model.name ?? "",
              style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
