import 'package:departure/screens/champion_screen.dart';
import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';
import 'package:departure/utilities/constants.dart';

class WorldcupScreen extends StatefulWidget {
  final int counter;

  WorldcupScreen({Key key, @required this.counter}) : super(key: key);

  @override
  _WorldcupScreenState createState() => _WorldcupScreenState(counter);
}

class _WorldcupScreenState extends State<WorldcupScreen> {
  MenuList menuList;
  Menu topMenu, bottomMenu;
  int topMenuIndex = 0, bottomMenuIndex = 1;
  int currentRound;
  final int counter;
  _WorldcupScreenState(this.counter);

  @override
  void initState() {
    currentRound = counter;
    menuList = MenuList(counter);
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
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  topMenu.name,
                  style: kNameStyle,
                ),
              ),
              Image(
                image: AssetImage(topMenu.imageLink),
                height: MediaQuery.of(context).size.height * 0.27,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  topMenu.hashTags,
                  style: kBlackLabelStyle,
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
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  bottomMenu.name,
                  style: kNameStyle,
                ),
              ),
              Image(
                image: AssetImage(bottomMenu.imageLink),
                height: MediaQuery.of(context).size.height * 0.27,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  bottomMenu.hashTags,
                  style: kBlackLabelStyle,
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
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _topBtn(),
                const Divider(
                  color: Colors.red,
                  height: 40,
                  thickness: 10,
                  indent: 0,
                  endIndent: 0,
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
