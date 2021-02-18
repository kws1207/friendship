import 'package:flutter/material.dart';
import 'package:departure/utilities/constants.dart';
import 'package:departure/screens/worldcup_screen.dart';
import 'package:departure/domain/classes.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => new _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  int _counter = 8;
  bool korean, bunsik, japanese, western, chinese;
  List<Menu> menuList;

  @override
  void initState() {
    korean = true;
    bunsik = true;
    japanese = true;
    western = true;
    chinese = true;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ㅠㅠ"),
          content: Text("메뉴가 부족합니다......."),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
      builder: (context) => WorldcupScreen(
        counter: _counter,
        menuList: menuList,
      ),
    ));
  }

  Widget _koreanCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: korean,
          onChanged: (value) {
            setState(() {
              korean = !korean;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.red,
        ),
        InkWell(
          onTap: () {
            setState(() {
              korean = !korean;
            });
          },
          child: Text(
            '한식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _bunsikCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: bunsik,
          onChanged: (value) {
            setState(() {
              bunsik = !bunsik;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.red,
        ),
        InkWell(
          onTap: () {
            setState(() {
              bunsik = !bunsik;
            });
          },
          child: Text(
            '분식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _japaneseCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: japanese,
          onChanged: (value) {
            setState(() {
              japanese = !japanese;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.red,
        ),
        InkWell(
          onTap: () {
            setState(() {
              japanese = !japanese;
            });
          },
          child: Text(
            '일본음식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _westernCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: western,
          onChanged: (value) {
            setState(() {
              western = !western;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.red,
        ),
        InkWell(
          onTap: () {
            setState(() {
              western = !western;
            });
          },
          child: Text(
            '아시안 / 양식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _chineseCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: chinese,
          onChanged: (value) {
            setState(() {
              chinese = !chinese;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.red,
        ),
        InkWell(
          onTap: () {
            setState(() {
              chinese = !chinese;
            });
          },
          child: Text(
            '중국음식 (마라요리, 훠궈 등 포함)',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _buildSelectRoundRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "decrementBtn", // multiple heroes exception
          backgroundColor: Colors.grey,
          onPressed: _decrementCounter,
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        Text("$_counter" + "강",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'BMYS',
                fontSize: 84.0,
                fontWeight: FontWeight.normal)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        FloatingActionButton(
          heroTag: "incrementBtn", // multiple heroes exception
          backgroundColor: Colors.grey,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          '메뉴 이상형 월드컵',
          style: kWhiteLabelStyle,
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
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    children: <Widget>[
                      _koreanCheckBox(),
                      _bunsikCheckBox(),
                      _japaneseCheckBox(),
                      _westernCheckBox(),
                      _chineseCheckBox(),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                _buildSelectRoundRow(),

                // 월드컵 시작 버튼
                FutureBuilder<void>(
                  future: loadCSV(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 25.0),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          menuList = getMenuList(_counter, korean, bunsik,
                              japanese, western, chinese);
                          if (menuList == null)
                            _showDialog();
                          else
                            navigationPage();
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.red,
                        child: Text(
                          '월드컵 시작!',
                          style: kWhiteLabelStyle,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
