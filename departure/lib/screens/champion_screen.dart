import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';
import 'package:departure/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChampionScreen extends StatefulWidget {
  final Menu champion;

  ChampionScreen({Key key, @required this.champion}) : super(key: key);

  @override
  _ChampionScreenState createState() => _ChampionScreenState(champion);
}

class _ChampionScreenState extends State<ChampionScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool _saveChampion;
  Menu champion;

  _ChampionScreenState(this.champion);

  @override
  void initState() {
    _saveChampion = true;
    // champion = null;
  }

  void saveChampion() {
    _firestore.collection('/history').add({
      // "user" :
      "name": champion.name
    });
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
          style: kWhiteLabelStyle,
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
          style: kWhiteLabelStyle,
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
                vertical: MediaQuery.of(context).size.height * 0.07,
              ),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/crown.png'),
                    width: 128,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Text(
                    '"' + champion.name + '"',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BMYS',
                      fontSize: MediaQuery.of(context).size.height * 0.08,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Container(
                    child: Image(
                      image: AssetImage(champion.imageLink),
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    decoration: kImageShadowStyle,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    champion.hashTags,
                    style: kBlackLabelStyle,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            _saveChampion = !_saveChampion;
                          });
                        },
                        child: Text(
                          '결과 저장하기',
                          style: kBlackLabelStyle,
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
