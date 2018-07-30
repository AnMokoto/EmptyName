import 'package:flutter/material.dart';
import 'package:lowlottery/common/mvp.dart';

class SplashLayer extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashLayer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Image.network(
        "",
        fit:BoxFit.fitWidth
        );
    );
  }
}
