import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'MineContract.dart';
import 'package:lowlottery/layout/record/LotteryBetRecord.dart';

class MineLayer extends StatefulWidget {
  _MineState createState() => new _MineState(new MinePresenter());
}

class _MineState extends MVPState<MinePresenter, MineLayer>
    implements MineIView {
  _MineState(MinePresenter presenter) : super(presenter);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey,
      child: new Column(
        children: <Widget>[
          new AspectRatio(
            aspectRatio: 1.0,
            child: new Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                new AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Image.asset(
                    "assets/images/app_back.png",
                    fit: BoxFit.cover,
                  ),
                ), //

                new Container(
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(top: 40.0),
                  constraints: new BoxConstraints(minWidth: double.infinity),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: new Column(
                          children: <Widget>[
                            Icon(Icons.whatshot),
                            new Text(
                              "111",
                              style: new TextStyle(
                                  fontSize: 15.0, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      //// 钱
                      new Container(
                        constraints: new BoxConstraints(
                            minWidth: double.infinity, minHeight: 200.0),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: new Center(
                          child: new Text("data"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            color: Colors.white,
            child: new ListTile(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new LotterBetRecordLayer(),
                    ));
              },
              leading: Icon(Icons.history),
              title: new Text("投注记录"),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }
}
