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

  Widget _buildSearchBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {print("")},
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red,
        child: Text(
          '맛집 찾아보기 ➔',
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
    print(champion.name);
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
                  Text('"' + champion.name + '"',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'BMYS',
                        fontSize: 84.0,
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(height: 80.0),
                  Image(
                    image: AssetImage(champion.imageLink),
                    width: 400,
                  ),
                  SizedBox(height: 30.0),
                  Text(champion.hashTags,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'BMDH',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(height: 80.0),
                  _buildSearchBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
