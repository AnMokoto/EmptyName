import 'package:flutter/material.dart';
import '../style/style.dart' show LotteryStyle, LotteryStyleDefault;

//// 一种类型,只负责切割布局
class Lottery2Layer extends StatelessWidget {
  Widget billboard;
  LotteryStyle style;
  List<Widget> child;

  Lottery2Layer(
      {this.billboard, @required this.style, @required this.child, Key key})
      : super(key: key) {
    this.style = style ?? LotteryStyleDefault();
  }

  @protected
  Widget build(BuildContext context) {
    int count = style.maxLineCount;
    int column = (child.length / count).ceil();

    return new Container(
      constraints: BoxConstraints.tightFor(),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Offstage(offstage: billboard == null, child: billboard),
          new Expanded(
            child: new Container(
              constraints: BoxConstraints.tightFor(),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: new List.generate(column, (index) {
                  /// 返回行显示
                  final start = index * count;

                  /// 返回当前次数下需要显示的个数
                  //final _count = max(0, min(count, child.length - start));
                  //if (_count > 0) {
                  ///  返回需要显示的数据
                  return new Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.all(5.0),
                    color: Colors.transparent,
                    constraints: BoxConstraints.tightFor(),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: new List.generate(count, (i) {
                        final _start = start + i;
                        if (_start < child.length) {
                          return new Expanded(child: child[_start]);
                        } else {
                          return new Expanded(
                            child: new Container(),
                          );
                        }
                      }),
                    ),
                  );
                  // }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
