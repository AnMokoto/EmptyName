import 'package:flutter/material.dart';

import 'package:lowlottery/layout/home/index/IndexFragLayer.dart';
import 'package:lowlottery/layout/home/mine/MineLayer.dart';
import 'package:lowlottery/layout/home/opencode/OpencodeRecord.dart';
import 'package:lowlottery/font/index.dart';
class HomeLayer extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeLayer> {
  PageController _pageController;

  int _currentIndex = 0;

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
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        controller: _pageController,
        itemBuilder: (context, index) {
          return layer[index];
        },
        itemCount: 3,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(AppIcons.home ,size: 24.0,), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(AppIcons.jiangbei ,size: 24.0,), title: Text("开奖号码")),
          BottomNavigationBarItem(
              icon: Icon(AppIcons.persion ,size: 24.0,), title: Text("个人中心")),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 20),
              curve: ElasticOutCurve(0.6));
          _onPageChanged(index);
        },
      ),
    );
  }
}
