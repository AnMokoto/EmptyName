import 'package:flutter/material.dart';

import 'index/IndexFragLayer.dart';
import 'mine/MineLayer.dart';
import 'opencode/OpencodeRecord.dart';
import 'hall/HallLayer.dart';
import 'package:lowlottery/font/index.dart';

class HomeLayer extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<HomeLayer> {
  PageController _pageController;

  int _currentIndex = 0;

  List<Widget> layer = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new IndexFragLayer(),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new HallLayer(),
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

  final List<BottomNavigationBarItem> bottomBar = [
    BottomNavigationBarItem(
        activeIcon: Icon(
          AppIcons.home,
          color: Colors.red,
        ),
        icon: Icon(
          AppIcons.home,
          color: Colors.grey,
        ),
        title: Text("首页")),
    BottomNavigationBarItem(
      activeIcon: Icon(
        AppIcons.home,
        color: Colors.red,
      ),
      icon: Icon(
        AppIcons.home,
        color: Colors.grey,
      ),
      title: Text("购彩大厅"),
    ),
    BottomNavigationBarItem(
        activeIcon: Icon(
          AppIcons.jiangbei,
          color: Colors.red,
        ),
        icon: Icon(
          AppIcons.jiangbei,
          color: Colors.grey,
        ),
        title: Text("开奖号码")),
    BottomNavigationBarItem(
        activeIcon: Icon(
          AppIcons.persion,
          color: Colors.red,
        ),
        icon: Icon(
          AppIcons.persion,
          color: Colors.grey,
        ),
        title: Text("个人中心")),
  ];

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

  void onPageChanged(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 20), curve: ElasticOutCurve(0.6));
    _onPageChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView.builder(
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        controller: _pageController,
        itemBuilder: (context, index) {
          return layer[index];
        },
        itemCount: 3,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: bottomBar,
        currentIndex: _currentIndex,
        onTap: (index) {
          onPageChanged(index);
        },
      ),
    );
  }
}
