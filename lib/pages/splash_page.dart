import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  static Route route(){
    return MaterialPageRoute(builder: (_) => SplashPage());
  }
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Image.asset(
        "images/splash.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

}