import 'package:flutter/material.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:where_to_eat/domain/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Menu> menuList;
  final locationController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final String uid;
  static final storage = FlutterSecureStorage();

  _SelectScreenState(this.uid);

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

  /*
  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/WorldcupScreen'),
      builder: (context) => WorldcupScreen(
        counter: _counter,
        menuList: menuList,
        uid: uid,
      ),
    ));
  }
  */

  void navigationToSignInPage() {
    Navigator.of(context).pushReplacementNamed('/SignInScreen');
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
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.red,
              ),
              hintText: '장소 검색',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01, horizontal: 25.0),
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
        color: Colors.red[300],
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
        backgroundColor: Colors.red,
        title: Text(
          '메뉴 이상형 월드컵',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                _searchLocationTF(),
                // 월드컵 시작 버튼
                FutureBuilder<void>(
                  future: loadCSV(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.03,
                          horizontal: 25.0),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          /*menuList = getMenuList(_counter, korean, bunsik,
                              japanese, western, chinese);
                          if (menuList == null) _showLessMenuDialog();*/
                          //navigationPage();
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.red,
                        child: Text(
                          '월드컵 시작!',
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
        ],
      ),
    );
  }
}
