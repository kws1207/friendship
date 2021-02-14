import 'package:departure/champion_screen.dart';
import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';

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
            print(menuList.menuList[0].name);
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
            print(menuList.menuList[0].name);
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
                Text(
                  topMenu.name,
                ),
                Text(
                  topMenu.hashTags,
                ),
                Image(
                    image: AssetImage(topMenu.imageLink),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.3),
              ],
            ))));
  }

  Widget _bottomBtn() {
    return InkWell(
        onTap: () => bottomPressed(),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
                child: Column(
              children: <Widget>[
                Text(
                  bottomMenu.name,
                ),
                Text(
                  bottomMenu.hashTags,
                ),
                Image(
                    image: AssetImage(bottomMenu.imageLink),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.3),
              ],
            ))));
  }

  @override
  Widget build(BuildContext context) {
    topMenu = menuList.menuList[topMenuIndex];
    bottomMenu = menuList.menuList[bottomMenuIndex];
    return Scaffold(
      appBar: AppBar(title: Text(currentRound.toString() + '강')),
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
                vertical: 80.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_topBtn(), _bottomBtn()],
              ),
            ),
          )
        ],
      ),
    );
  }
}
