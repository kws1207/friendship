import 'package:flutter/material.dart';
import 'package:departure/domain/classes.dart';

class WorldcupScreen extends StatefulWidget {
  @override
  _WorldcupScreenState createState() => _WorldcupScreenState();
}

class _WorldcupScreenState extends State<WorldcupScreen> {
  MenuList menuList = MenuList(4);
  Menu topMenu, bottomMenu;
  num topMenuIndex = 0, bottomMenuIndex = 1;
  num currentRound = 4;

  topPressed() => setState(() {
        if (menuList.menuList.length - 1 == bottomMenuIndex) {
          topMenuIndex = 0;
          bottomMenuIndex = 1;
          currentRound /= 2;
        } else {
          topMenuIndex += 1;
          bottomMenuIndex += 1;
          menuList.menuList.removeAt(bottomMenuIndex);
        }
      });
  bottomPressed() => setState(() {
        if (menuList.menuList.length - 1 == bottomMenuIndex) {
          topMenuIndex = 0;
          bottomMenuIndex = 1;
          currentRound /= 2;
        } else {
          topMenuIndex += 1;
          bottomMenuIndex += 1;
          menuList.menuList.removeAt(topMenuIndex);
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
