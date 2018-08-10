library FixBoxWidget;

import 'package:flutter/material.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';

/// @auther An'Mokoto
/// @desc item to show container
@immutable
class FixBoxWidget extends StatefulWidget {
  final int count;
  final Axis direction;

  List<FixBoxModel> models;

  FixBoxWidget(
      {Key key,
      this.count = 3,
      this.direction = Axis.vertical,
      @required this.models})
      : assert(models != null),
        super(key: key);

  @override
  FixBoxState createState() => new FixBoxState();
}

class FixBoxState extends State<FixBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      crossAxisCount: widget.count,
      scrollDirection: widget.direction,
      children: widget.models.map((f) {
        return new FixBoxWidgetItem(model: f);
      }).toList(),
      padding: const EdgeInsets.all(5.0),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    );
  }
}

class FixBoxWidgetItem extends StatefulWidget {
  final FixBoxModel model;

  @override
  FixBoxWidgetItemState createState() => new FixBoxWidgetItemState();

  FixBoxWidgetItem({Key key, this.model})
      : assert(model != null),
        super(key: key);
}

class FixBoxWidgetItemState extends State<FixBoxWidgetItem> {
  void _onFixBoxTopClick(int id) {
    
  }

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.contain,
      alignment: AlignmentDirectional.center,
      child: new InkWell(
        onTap: () {
          _onFixBoxTopClick(widget.model.id);
        },
        child: new Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(widget.model.url ??
                  ""), //NetworkImage(widget.model.url ?? "")
              radius: 90.0,
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
