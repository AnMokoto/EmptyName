import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:lowlottery/widget/fixbox/FixBoxWidget.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:lowlottery/layout/lottery/LotteryLayer.dart';
import 'package:lowlottery/style/index.dart' show StyleSplit;
import 'package:lowlottery/store/appStore.dart';
import 'dart:async';

class IndexFragLayer extends StatefulWidget {
  // final index_type = [
  //   "assets/lottery/cqssc.png",
  //   "assets/lottery/pk10.png",
  //   "assets/lottery/tjssc.png",
  //   "assets/lottery/xjssc.png",
  //   "assets/lottery/cqssc.png",
  // ];

  IndexFragLayer({Key key}) : super(key: key);
  @override
  _IndexFragState createState() => new _IndexFragState();
}

class _IndexFragState extends State<IndexFragLayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dispatch(context, new IndexRequestAction(context, {'type':'home'}));
    dispatch(context, new BannerRequestAction(context, new Map()));
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535553838059&di=1ca43aa1c063ce6d4ac55478f156a30e&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0153ed5850ab46a8012060c8c42cd9.png%40900w_1l_2o_100sh.jpg'
            ,
            fit: BoxFit.cover,
          ),
        ), //banner
        /*new Align(
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
        ),*/
        new Expanded(
          child: new StoreConnector<AppState, List<FixBoxModel>>(
            builder: (context, state) {
              return new FixBoxWidget(
                  models: state ?? [],
                  onItemClick: (model, position) {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new LotteryLayer(
                            impl: StyleSplit.of(model.gameEn),
                            gameEn: model.gameEn,
                          ),
                    ));
                  });
            },
            converter: (state) {
              return state.state.homeModel.model;
            },
          ),
        ),
      ],
    );
  }
}
