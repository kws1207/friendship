import 'package:flutter/material.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:where_to_eat/domain/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_to_eat/screens/list_screen.dart';

class SelectScreen extends StatefulWidget {
  final String uid;

  SelectScreen({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _SelectScreenState createState() => new _SelectScreenState(uid);
}

class _SelectScreenState extends State<SelectScreen> {
  final _firestore = FirebaseFirestore.instance;
  final String uid;
  static final storage = FlutterSecureStorage();
  final locationController = TextEditingController();

  _SelectScreenState(this.uid);

  @override
  void initState() {}

  Widget championHistory(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('favorites')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final DocumentSnapshot document = snapshot.data;
            return ListView(
              children: List.from(document['array'])
                  .map(
                    (name) => Card(
                      child: ListTile(
                        title: Text(name),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Card(
              child: Text("Loading..."),
            );
          }
        });
  }

  Widget _searchLocationTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '장소를 입력하세요',
          style: kBlackLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextField(
            controller: locationController,
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(
              color: Colors.orange,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.orange,
              ),
              hintText: '장소 검색',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  void _showSignOutFailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ㅠㅠ"),
          content: Text("로그아웃 실패!"),
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

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '명예의 전당',
                style: kWhiteLabelStyle,
              ),
              backgroundColor: Colors.orange[400],
            ),
            body: championHistory(context),
          );
        }, // ...to here.
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/ListScreen'),
      builder: (context) => ListScreen(
        uid: uid,
      ),
    ));
  }

  void navigationToSignInPage() {
    Navigator.of(context).pushReplacementNamed('/SignInScreen');
  }

/*
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
  */

  Widget _buildSignOutBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.01,
      ),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await FirebaseAuth.instance.signOut().then(
            (_) async {
              storage.delete(key: 'email');
              storage.delete(key: 'password');
              storage.delete(key: 'uid');
              navigationToSignInPage();
            },
            onError: (error) => _showSignOutFailDialog(),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orange[300],
        child: Text(
          '로그아웃',
          style: kWhiteLabelStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          '어디갈랭',
          style: kWhiteLabelStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => {_pushSaved()},
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.11,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _searchLocationTF(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  // 시작 버튼
                  FutureBuilder<void>(
                    future: loadCSV(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.03,
                        ),
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            navigationPage();
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.orange,
                          child: Text(
                            '식당 찾기',
                            style: kWhiteLabelStyle,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildSignOutBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
