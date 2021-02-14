import 'dart:async';
import 'package:flutter/material.dart';
import 'package:departure/login_screen.dart';
import 'package:departure/select_screen.dart';
import 'package:departure/worldcup_screen.dart';
import 'package:departure/champion_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/LoginScreen': (BuildContext context) => LoginScreen(),
      '/SelectScreen': (BuildContext context) => SelectScreen(),
      '/WorldcupScreen': (BuildContext context) => WorldcupScreen(),
      '/ChampionScreen': (BuildContext context) => ChampionScreen()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, navigationPage);
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
