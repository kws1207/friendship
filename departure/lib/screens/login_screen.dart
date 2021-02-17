import 'package:flutter/material.dart';
import 'package:departure/utilities/constants.dart';
import 'package:departure/firebase/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/SelectScreen');
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          '비밀번호가 뭐였지?',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'BMYS',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await AuthService()
              .signInWithEmailAndPassword(
                emailController.text,
                passwordController.text,
              )
              .then(
                (_) => navigationPage(),
              );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red,
        child: Text(
          '로그인',
          style: kWhiteLabelStyle,
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '아니면...',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'BMYS',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          '소셜 로그인하기',
          style: kBlackLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Kakaotalk'),
            AssetImage(
              'assets/logos/kakaotalk.png',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.png',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () async {
        await AuthService()
            .signUpWithEmailAndPassword(
              emailController.text,
              passwordController.text,
            )
            .then(
              (_) => navigationPage(),
            );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '혹시 처음이야? ',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'BMYS',
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: '눌러서 회원가입',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'BMDH',
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
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
            alignment: Alignment.center,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.09,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '아이디가 뭐였지?',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BMYS',
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _buildEmailTF(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _buildPasswordTF(),
                  _buildForgotPasswordBtn(),
                  _buildLoginBtn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  _buildSignInWithText(),
                  _buildSocialBtnRow(),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  _buildSignupBtn(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
