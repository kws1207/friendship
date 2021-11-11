import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:where_to_eat/domain/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_to_eat/screens/list_screen.dart';
import 'package:kpostal/kpostal.dart';
import 'package:kpostal/src/kpostal_model.dart';
import 'package:where_to_eat/utilities/functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Kpostal kopoModel = null;
  Restaurant currentLocation;

  bool _isLocationLoading = false;

  _SelectScreenState(this.uid);

  @override
  void initState() {
    super.initState();
  }

  Widget _searchLocationTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '장소를 검색하세요',
          style: kBlackLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: MediaQuery.of(context).size.height * 0.07,
          child: InkWell(
            onTap: () async {
              Kpostal model = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KpostalView(),
                ),
              );
              if (model != null) {
                setState(() {
                  kopoModel = model;
                });
              }
            },
            child: TextField(
              enabled: false,
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
                hintText: (kopoModel == null) ? '장소 검색' : kopoModel.address,
                hintStyle: kHintTextStyle,
              ),
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
          title: Text("Error"),
          content: Text("로그아웃 실패.. 관리자에게 문의하세요"),
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

  void navigationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListScreen(
          uid: uid,
          kopoModel: kopoModel,
        ),
      ),
    );
  }

  void navigationToSignInPage() {
    Navigator.of(context).pushReplacementNamed('/SignInScreen');
  }

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
            onError: (error) => showNativeDialog(error, context),
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

  Widget _searchCurrentLocationBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.03,
      ),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          setState(() {
            _isLocationLoading = true;
          });
          await _getCurrentLocation();
          print(currentLocation.address_name);
          // ignore: missing_required_param
          kopoModel = Kpostal(
            address: currentLocation.address_name,
          );
          setState(() {
            _isLocationLoading = false;
          });
        },
        //navigationPage();
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orangeAccent,
        child: Text(
          '현위치',
          style: kWhiteLabelStyle,
        ),
      ),
    );
  }

  Widget _searchRestaurantBtn() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.03,
      ),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (kopoModel != null) {
            navigationPage();
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: (kopoModel != null) ? Colors.orange : Colors.grey,
        child: Text(
          (kopoModel != null) ? '식당 찾기' : '먼저 장소를 검색하세요',
          style: kWhiteLabelStyle,
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print(position.latitude);
    print(position.longitude);

    await _getLocationFromCoordinates(
        position.latitude.toString(), position.longitude.toString());
  }

  void _getLocationFromCoordinates(String latitude, String longitude) async {
    var url = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=' +
            longitude +
            '&y=' +
            latitude);

    var response = await http.post(url,
        headers: {'Authorization': 'KakaoAK f7fe1cb54eecf69fc022ce8035f1e369'});

    print(response.body);
    final parsed =
        json.decode(response.body)["documents"].cast<Map<String, dynamic>>();

    setState(() {
      currentLocation = parsed
          .map<Restaurant>((json) => Restaurant.fromJsonRegion(json))
          .toList()[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(uid);
    if (_isLocationLoading) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            '어디갈랭',
            style: kWhiteLabelStyle,
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
                    _searchCurrentLocationBtn(),
                    _searchRestaurantBtn(),
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
}
