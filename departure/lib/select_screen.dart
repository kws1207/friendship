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
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          '메뉴 이상형 월드컵',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'BMDH',
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => {print("menu icon pressed")}),
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/trophy.png'),
                  width: 400,
                ),
                SizedBox(height: 30),
                Text(
                  '회색 버튼을 이용하여\n\n4강부터 32강까지 선택 가능합니다.',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BMDH',
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.grey,
                      onPressed: _decrementCounter,
                      tooltip: 'Decrement',
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 30),
                    Text("$_counter" + "강",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'BMYS',
                            fontSize: 84.0,
                            fontWeight: FontWeight.normal)),
                    SizedBox(width: 30),
                    FloatingActionButton(
                      backgroundColor: Colors.grey,
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
        ],
      ),
    );
  }
}
