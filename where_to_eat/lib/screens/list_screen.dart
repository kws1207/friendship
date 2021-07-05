import 'package:flutter/material.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:where_to_eat/domain/classes.dart';

class ListScreen extends StatefulWidget {
  final String uid;

  const ListScreen({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState(uid);
}

class _ListScreenState extends State<ListScreen> {
  final String uid;
  bool korean, bunsik, japanese, western, chinese;

  _ListScreenState(this.uid);

  @override
  void initState() {
    korean = true;
    bunsik = true;
    japanese = true;
    western = true;
    chinese = true;
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
          activeColor: Colors.orange,
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
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              bunsik = !bunsik;
            });
          },
          child: Text(
            '분식 / 패스트푸드',
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
          activeColor: Colors.orange,
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
          activeColor: Colors.orange,
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
          activeColor: Colors.orange,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Row(
                children: <Widget>[
                  _koreanCheckBox(),
                  _bunsikCheckBox(),
                  _japaneseCheckBox(),
                  _westernCheckBox(),
                  _chineseCheckBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
