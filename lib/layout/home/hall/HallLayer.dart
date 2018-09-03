import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lowlottery/store/AppStore.dart';
import 'package:lowlottery/widget/fixbox/FixBoxModel.dart';
import 'package:lowlottery/widget/fixbox/FixBoxWidget.dart';
import 'package:lowlottery/style/index.dart';
import 'package:lowlottery/layout/lottery/LotteryLayer.dart';
import 'package:lowlottery/font/index.dart';
import 'package:lowlottery/layout/home/HomeLayer.dart';

class HallLayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HallState();
  }
}

@protected
class _HallState extends State<HallLayer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("购彩大厅"),
        centerTitle: true,
        leading: new InkWell(
          onTap: () {
            HomeState state =
                context.ancestorStateOfType(const TypeMatcher<HomeState>());
            state.onPageChanged(0);
          },
          child: Icon(
            AppIcons.home,
            size: 24.0,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: new HallIndexLayer(),
    );
  }
}

class HallIndexLayer extends StatefulWidget {
  HallIndexLayer({Key key}) : super(key: key);
  @override
  _IndexFragState createState() => new _IndexFragState();
}

class _IndexFragState extends State<HallIndexLayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dispatch(context, new IndexRequestAction(context, {'type': 'all'}));
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<FixBoxModel>>(
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
        return state.state.homeModel.third;
      },
    );
  }
}
