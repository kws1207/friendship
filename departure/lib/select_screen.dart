import 'package:flutter/material.dart';
import 'package:departure/main.dart';
import 'package:departure/worldcup_screen.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => new _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  int _counter = 8;

  void _incrementCounter() {
    setState(() {
      if (_counter <= 16) _counter *= 2;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter >= 8) _counter ~/= 2;
    });
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/WorldcupScreen'),
      builder: (context) => WorldcupScreen(counter: _counter),
    ));
  }

  Widget _worldcupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => navigationPage(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red,
        child: Text(
          '월드컵 시작!',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'BMDH',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("$_counter" + "강",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'BMYS',
                          fontSize: 36.0,
                          fontWeight: FontWeight.normal)),
                  Row(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: _decrementCounter,
                        tooltip: 'Decrement',
                        child: Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        onPressed: _incrementCounter,
                        tooltip: 'Increment',
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                  _worldcupBtn()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
