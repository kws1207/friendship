import 'package:departure/screens/champion_screen.dart';
import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';
import 'package:departure/utilities/constants.dart';

class WorldcupScreen extends StatefulWidget {
  final int counter;
  final bool korean, bunsik, japanese, western, chinese;

  WorldcupScreen({
    Key key,
    @required this.counter,
    @required this.korean,
    @required this.bunsik,
    @required this.japanese,
    @required this.western,
    @required this.chinese,
  }) : super(key: key);

  @override
  _WorldcupScreenState createState() =>
      _WorldcupScreenState(counter, korean, bunsik, japanese, western, chinese);
}

class _WorldcupScreenState extends State<WorldcupScreen> {
  MenuList menuList;
  Menu topMenu, bottomMenu;
  int topMenuIndex = 0, bottomMenuIndex = 1;
  int currentRound;
  final int counter;
  final bool korean, bunsik, japanese, western, chinese;
  _WorldcupScreenState(this.counter, this.korean, this.bunsik, this.japanese,
      this.western, this.chinese);

  @override
  void initState() {
    currentRound = counter;
    menuList = MenuList(counter, true, true, true, true);
  }

  void navigationPage(Menu champion) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/ChampionScreen'),
      builder: (context) => ChampionScreen(champion: champion),
    ));
  }

  topPressed() => setState(() {
        menuList.menuList.removeAt(bottomMenuIndex);
        topMenuIndex += 1;
        bottomMenuIndex += 1;
        if (menuList.menuList.length + 1 == bottomMenuIndex) {
          topMenuIndex = 0;
          bottomMenuIndex = 1;
          currentRound ~/= 2;
          if (currentRound == 1) {
            navigationPage(menuList.menuList[0]);
            bottomMenuIndex = 0;
          }
        }
      });
  bottomPressed() => setState(() {
        menuList.menuList.removeAt(topMenuIndex);
        topMenuIndex += 1;
        bottomMenuIndex += 1;
        if (menuList.menuList.length + 1 == bottomMenuIndex) {
          topMenuIndex = 0;
          bottomMenuIndex = 1;
          currentRound ~/= 2;
          if (currentRound == 1) {
            navigationPage(menuList.menuList[0]);
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
    topMenu = menuList.menuList[topMenuIndex];
    bottomMenu = menuList.menuList[bottomMenuIndex];
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
