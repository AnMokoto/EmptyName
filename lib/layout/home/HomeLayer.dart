import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/layout/home/HomeContract.dart';
import 'package:lowlottery/layout/home/index/IndexFragLayer.dart';
import 'package:lowlottery/layout/home/mine/MineLayer.dart';
import 'package:lowlottery/layout/home/opencode/OpencodeRecord.dart';
import 'package:flutter/foundation.dart';

class HomeLayer extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState(new HomePresenter());
}

class _HomeState extends MVPState<HomePresenter, HomeLayer>
    with AutomaticKeepAliveClientMixin<HomeLayer>
    implements HomeIView {
  PageController _pageController;

  int _currentIndex = 0;

  _HomeState(HomePresenter presenter) : super(presenter);

  List<Widget> layer = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new IndexFragLayer(),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new OpencodeRecordLayer(),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new MineLayer(),
    )
  ];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(
      initialPage: 0,
      keepPage: true,
    );
    /*_tabController = new TabController(
        length: 4,
        vsync: this
    );*/
  }

  void _onPageChanged(int index) {
    setState(() {
      if (_currentIndex != index) {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView.builder(
        physics: new PageScrollPhysics(),
        onPageChanged: _onPageChanged,
        controller: _pageController,
        itemBuilder: (context, index) {
          return layer[index];
        },
        itemCount: 3,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("开奖号码")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("个人中心")),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200),
              curve: ElasticOutCurve(0.6));
          _onPageChanged(index);
        },
      ),
    );
  }
}
