import 'dart:async';
import 'package:flutter/material.dart';
import 'package:departure/screens/signin_screen.dart';
import 'package:departure/screens/select_screen.dart';
import 'package:departure/screens/worldcup_screen.dart';
import 'package:departure/screens/champion_screen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Disable Screen Rotation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/SignInScreen': (BuildContext context) => SignInScreen(),
        // ignore: missing_required_param
        '/SelectScreen': (BuildContext context) => SelectScreen(),
        // ignore: missing_required_param
        '/WorldcupScreen': (BuildContext context) => WorldcupScreen(),
        // ignore: missing_required_param
        '/ChampionScreen': (BuildContext context) => ChampionScreen()
      },
      // title: '메뉴 이상형월드컵',
      // theme: ThemeData.dark(),
    );
  }
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
    Navigator.of(context).pushReplacementNamed('/SignInScreen');
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
        child: Image.asset('assets/images/splash_img.jpeg'),
      ),
    );
  }
}
