import 'package:departure/screens/champion_screen.dart';
import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';
import 'package:departure/utilities/constants.dart';

class WorldcupScreen extends StatefulWidget {
  final int counter;
  final List<Menu> menuList;
  final String uid;

  WorldcupScreen({
    Key key,
    @required this.counter,
    @required this.menuList,
    @required this.uid,
  }) : super(key: key);

  @override
  _WorldcupScreenState createState() =>
      _WorldcupScreenState(counter, menuList, uid);
}

class _WorldcupScreenState extends State<WorldcupScreen> {
  List<Menu> _menuList, menuList;
  Menu topMenu, bottomMenu;
  int topMenuIndex = 0, bottomMenuIndex = 1;
  int currentRound;
  final int counter;
  final String uid;
  _WorldcupScreenState(this.counter, this.menuList, this.uid);

  @override
  void initState() {
    currentRound = counter;
    _menuList = menuList;
  }

  void navigationPage(Menu champion) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/ChampionScreen'),
      builder: (context) => ChampionScreen(
        champion: champion,
        uid: uid,
      ),
    ));
  }

  topPressed() => setState(() {
        _menuList.removeAt(bottomMenuIndex);
        topMenuIndex += 1;
        bottomMenuIndex += 1;
        if (_menuList.length + 1 == bottomMenuIndex) {
          topMenuIndex = 0;
          bottomMenuIndex = 1;
          currentRound ~/= 2;
          if (currentRound == 1) {
            navigationPage(_menuList[0]);
            bottomMenuIndex = 0;
          }
        }
      });
  bottomPressed() => setState(() {
        _menuList.removeAt(topMenuIndex);
        topMenuIndex += 1;
        bottomMenuIndex += 1;
        if (_menuList.length + 1 == bottomMenuIndex) {
          topMenuIndex = 0;
          bottomMenuIndex = 1;
          currentRound ~/= 2;
          if (currentRound == 1) {
            navigationPage(_menuList[0]);
            bottomMenuIndex = 0;
          }
        }
      });

  Widget _topBtn() {
    return InkWell(
      onTap: () => topPressed(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.38,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Text(
                  topMenu.name,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height * 0.05,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BMYS',
                  ),
                ),
              ),
              Image(
                image: AssetImage(topMenu.imageLink),
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  topMenu.hashTags,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BMDH',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomBtn() {
    return InkWell(
      onTap: () => bottomPressed(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.42,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Text(
                  bottomMenu.name,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height * 0.05,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BMYS',
                  ),
                ),
              ),
              Image(
                image: AssetImage(bottomMenu.imageLink),
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Text(
                  bottomMenu.hashTags,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BMDH',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    topMenu = _menuList[topMenuIndex];
    bottomMenu = _menuList[bottomMenuIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (currentRound == 2)
              ? '- 결승전 -'
              : '- ' + (currentRound.toString() + '강 -'),
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'BMDH',
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _topBtn(),
                const Divider(
                  color: Colors.red,
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                _bottomBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
