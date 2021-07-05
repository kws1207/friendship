import 'package:where_to_eat/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:where_to_eat/firebase/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:where_to_eat/screens/select_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_to_eat/utilities/functions.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // bool _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static final storage = FlutterSecureStorage();
  final _firestore = FirebaseFirestore.instance;

  String _userEmail, _userPassword, _userUID;

  User user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _asyncMethod(),
    );
  }

  _asyncMethod() async {
    // Not working on simulator, does it work on actual device?
    _userEmail = await storage.read(key: 'email');
    _userPassword = await storage.read(key: 'password');
    _userUID = await storage.read(key: 'uid');

    if (_userUID != null) navigationPage();
  }

  Future<User> _googleSignIn() async {
    await Firebase.initializeApp();
    print("google login try");
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print("google login 1");
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    print("google login 2");
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    print("google login 3");
    user = (await auth.signInWithCredential(credential)).user;
    if (user != null) {
      _userUID = user.uid;
    }

    if (AdditionalUserInfo().isNewUser) {
      _firestore.collection('favorites').doc(_userUID).set(
        {
          'array': FieldValue.arrayUnion(["--- 찜한 식당 목록 ---"]),
        },
        SetOptions(merge: true),
      );
    }

    print("google login finish");
    return user;
  }

  void _saveEmailPassword(
      String email, String password, String _userUID) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
    await storage.write(key: '_userUID', value: _userUID);
  }

  void navigationPage() {
    assert(_userUID != null);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      //new
      settings: const RouteSettings(name: '/SelectScreen'),
      builder: (context) => SelectScreen(
        uid: _userUID,
      ),
    ));
  }

  void pushSignUpPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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
      // ignore: deprecated_member_use
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

  Widget _buildSignInBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      width: MediaQuery.of(context).size.width * 0.35,
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
            (_) {
              user = AuthService().userInfo;
              _userUID = user.uid;
              _saveEmailPassword(
                  emailController.text, passwordController.text, _userUID);
              navigationPage();
            },
            onError: (error) => showNativeDialog(error, context),
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

  Widget _buildSignInAnonymously() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await auth.signInAnonymously().then(
            (_) {
              user = AuthService().userInfo;
              _userUID = user.uid;
              _firestore.collection('favorites').doc(_userUID).set(
                {
                  'array': FieldValue.arrayUnion(["--- 찜한 식당 목록 ---"]),
                },
                SetOptions(merge: true),
              );

              navigationPage();
            },
            onError: (error) => showNativeDialog(error, context),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.grey[600],
        child: Text(
          '비회원 로그인',
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('SignIn with Apple'),
            AssetImage(
              'assets/logos/apple.png',
            ),
          ),
          _buildSocialBtn(
            () async {
              try {
                await _googleSignIn();
                print("User is $user.");
              } catch (e, s) {
                showNativeDialog(e, context);
              }
              if (user != null) {
                navigationPage();
              }
            },
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
      onTap: () => pushSignUpPage(),
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
                vertical: MediaQuery.of(context).size.height * 0.11,
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
                  Row(
                    children: <Widget>[
                      _buildSignInBtn(),
                      _buildSignInAnonymously(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _buildSignupBtn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _buildSignInWithText(),
                  _buildSocialBtnRow(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
