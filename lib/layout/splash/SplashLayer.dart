import 'package:flutter/material.dart';
import 'package:lowlottery/store/appStore.dart';

/// @author An'Mokoto
/// @desc splash layer

class SplashLayer extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

// ignore: mixin_inherits_from_not_object
class SplashState extends State<SplashLayer>
    with TickerProviderStateMixin<SplashLayer> {
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
      // Navigator.of(context).pushAndRemoveUntil(
      //     new MaterialPageRoute(builder: (context) => new HomeLayer()),
      //     (route) => route = null);

      //Navigator.of(context).pushNamed("/home");
      if (state == AnimationStatus.completed) {
        dispatch(context, new LogStateAction(context: context));
        // Navigator.of(context).pushReplacement(
        //     new MaterialPageRoute(builder: (context) => new HomeLayer()));
      }
    };

    animation.addStatusListener(animationStateListener);
    //启动动画
    controller.forward();
  }

  void startNext() {}

  @override
  Widget build(BuildContext context) {
    /// todo will be check-in the state for login or sign up.
    return new FadeTransition(
      opacity: animation,
      child: new Image.asset(
        "assets/images/app_splash.png",
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
