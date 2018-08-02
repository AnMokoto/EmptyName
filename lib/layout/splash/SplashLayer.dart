import 'package:flutter/material.dart';

/// @author An'Mokoto
/// @desc splash layer

class SplashLayer extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashLayer> with TickerProviderStateMixin {
  // 动画
  Animation animation;

  // 动画管理器
  AnimationController controller;

  var animationStateListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 3000,
        ));

    animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    animationStateListener = (state) {
      if (state == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => null),
            (route) => route = null);
      }
    };

    animation.addStatusListener(animationStateListener);
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: animation,
      child: new Image.asset(
        "app_back.png",
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeStatusListener(animationStateListener);
    controller.dispose();
    super.dispose();
  }
}
