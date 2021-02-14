import 'dart:async';
import 'package:flutter/material.dart';
import 'package:departure/screens/login_screen.dart';
import 'package:departure/screens/select_screen.dart';
import 'package:departure/screens/worldcup_screen.dart';
import 'package:departure/screens/champion_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/LoginScreen': (BuildContext context) => LoginScreen(),
      '/SelectScreen': (BuildContext context) => SelectScreen(),
      // ignore: missing_required_param
      '/WorldcupScreen': (BuildContext context) => WorldcupScreen(),
      // ignore: missing_required_param
      '/ChampionScreen': (BuildContext context) => ChampionScreen()
    },
    // title: '메뉴 이상형월드컵',
    // theme: ThemeData.dark(),
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
