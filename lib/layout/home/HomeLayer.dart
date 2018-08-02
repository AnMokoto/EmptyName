import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/layout/home/HomeContract.dart';
import 'package:lowlottery/layout/home/index/IndexFragLayer.dart';

class HomeLayer extends StatefulWidget implements HomeIView {
  @override
  HomeState createState() => new HomeState(new HomePresenter(this));
}

class HomeState extends MVPState<HomePresenter, HomeLayer>
    with TickerProviderStateMixin {
  PageController _pageController;

  int _currentIndex = 0;

  HomeState(HomePresenter presenter) : super(presenter);

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
        onPageChanged: _onPageChanged,
        controller: _pageController,
        itemBuilder: (context, index) {

        },
        itemCount: 2,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Person")),
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
