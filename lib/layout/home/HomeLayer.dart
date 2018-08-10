import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';
import 'package:lowlottery/layout/home/HomeContract.dart';
import 'package:lowlottery/layout/home/index/IndexFragLayer.dart';

class HomeLayer extends StatefulWidget  {
  @override
  _HomeState createState() => new _HomeState(new HomePresenter());
}

class _HomeState extends MVPState<HomePresenter, HomeLayer> implements HomeIView{
  PageController _pageController;

  int _currentIndex = 0;

  _HomeState(HomePresenter presenter) : super(presenter);

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
        itemBuilder: (BuildContext, index) {
          return (<Widget>[
            new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new IndexFragLayer(),
            ),
            new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new IndexFragLayer(),
            )
          ])[index];
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
