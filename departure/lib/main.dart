import 'dart:async';
import 'package:flutter/material.dart';
import 'package:departure/login_screen.dart';
import 'package:departure/select_screen.dart';
import 'package:departure/worldcup_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/LoginScreen': (BuildContext context) => new LoginScreen(),
      '/SelectScreen': (BuildContext context) => new SelectScreen(),
      '/WorldcupScreen': (BuildContext context) => new WorldcupScreen()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LoginScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash_img.jpg'),
      ),
    );
  }
}
