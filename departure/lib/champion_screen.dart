import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';

class ChampionScreen extends StatefulWidget {
  final Menu champion;

  ChampionScreen({Key key, @required this.champion}) : super(key: key);

  @override
  _ChampionScreenState createState() => _ChampionScreenState(champion);
}

class _ChampionScreenState extends State<ChampionScreen> {
  final Menu champion;
  _ChampionScreenState(this.champion);

  bool _saveChampion;

  @override
  void initState() {
    _saveChampion = true;
  }

  void navigateToSelectScreen() {
    // TODO: 결과 저장하기 값 보내기
    Navigator.of(context).pushReplacementNamed('/SelectScreen');
  }

  Widget _buildSearchBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {print("SearchBtn pressed")},
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red,
        child: Text(
          '맛집 찾아보기',
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

  Widget _buildSelectScreenBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {navigateToSelectScreen()},
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red[300],
        child: Text(
          '처음 화면으로',
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
            alignment: Alignment.center,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 80.0,
              ),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/crown.png'),
                    width: 128,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    '"' + champion.name + '"',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BMYS',
                      fontSize: 84.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Image(
                    image: AssetImage(champion.imageLink),
                    height: 200,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    champion.hashTags,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BMDH',
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: _saveChampion,
                        onChanged: (value) {
                          setState(() {
                            _saveChampion = !_saveChampion;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.red,
                      ),
                      Text(
                        '결과 저장하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'BMDH',
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  _buildSearchBtn(),
                  _buildSelectScreenBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
