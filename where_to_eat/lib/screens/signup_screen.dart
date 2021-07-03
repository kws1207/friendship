import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:where_to_eat/firebase/auth.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:where_to_eat/screens/select_screen.dart';
import 'package:where_to_eat/utilities/functions.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();
  static final storage = FlutterSecureStorage();
  final _firestore = FirebaseFirestore.instance;
  String _userEmail, _userPassword, _userUID;

  User user;

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/SelectScreen'),
      builder: (context) => SelectScreen(
        uid: _userUID,
      ),
    ));
  }

  void _passwordUnmatchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ㅠㅠ"),
          content: Text("비밀번호를 다시 확인해주세요..."),
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

  void _saveEmailPassword(
      String email, String password, String _userUID) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
    await storage.write(key: '_userUID', value: _userUID);
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '아 이 디',
          style: kBlackLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.red,
              ),
              hintText: '이메일 주소',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '비 밀 번 호',
          style: kBlackLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
              hintText: '비밀번호',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordCheckTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '비 밀 번 호 확 인',
          style: kBlackLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextField(
            controller: passwordCheckController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
              hintText: '비밀번호 재입력',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (passwordController.text == passwordCheckController.text) {
            await AuthService()
                .signUpWithEmailAndPassword(
              emailController.text,
              passwordController.text,
            )
                .then(
              (_) {
                user = AuthService().userInfo;
                _userUID = user.uid;
                _saveEmailPassword(
                  emailController.text,
                  passwordController.text,
                  _userUID,
                );

                _firestore.collection('favorites').doc(_userUID).set(
                  {
                    'array': FieldValue.arrayUnion(["--- 찜한 식당 목록 ---"]),
                  },
                  SetOptions(merge: true),
                );

                navigationPage();
              },
              onError: (error) {
                showNativeDialog(error, context);
              },
            );
          } else
            _passwordUnmatchDialog();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red,
        child: Text(
          '회원가입',
          style: kWhiteLabelStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BMYS',
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.red,
        toolbarHeight: 70,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '안녕하세요!',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BMYS',
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _buildEmailTF(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _buildPasswordTF(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _buildPasswordCheckTF(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  _buildSignUpBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
