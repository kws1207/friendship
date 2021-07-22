import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:where_to_eat/domain/classes.dart';
import 'package:url_launcher/url_launcher.dart';

class RouletteScreen extends StatelessWidget {
  final List<Restaurant> rouletteList;
  final StreamController _dividerController = StreamController<int>();

  Map<int, String> labels = {};

  RouletteScreen({
    Key key,
    @required this.rouletteList,
  }) : super(key: key);

  dispose() {
    _dividerController.close();
  }

  void _launchURL(String url) async {
    //print(url);
    if (await canLaunch(Uri.encodeFull(url))) {
      await launch(Uri.encodeFull(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget rouletteScore(int selected) {
    return GestureDetector(
      onTap: () => _launchURL(
          'https://place.map.kakao.com/' + rouletteList[selected - 1].id),
      child: RichText(
        text: TextSpan(
          text: '카카오맵에서 열기',
          style: kBlackLabelStyle,
        ),
      ),
    );
  }

  Widget selectedLabel(int selected) {
    return Text(
      '${labels[selected]}',
      style: kNameStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    labels = {
      1: rouletteList[0].place_name,
      2: rouletteList[1].place_name,
      3: rouletteList[2].place_name,
      4: rouletteList[3].place_name,
      5: rouletteList[4].place_name,
      6: rouletteList[5].place_name,
    };

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange[100], elevation: 0.0),
      backgroundColor: Colors.orange[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('assets/images/wheel-6-300.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 6,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage:
                  Image.asset('assets/images/roulette-center-300.png'),
              secondaryImageHeight: 90,
              secondaryImageWidth: 90,
            ),
            SizedBox(height: 40),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) => snapshot.hasData
                  ? //selectedLabel(snapshot.data)
                  Column(
                      children: [
                        selectedLabel(snapshot.data),
                        SizedBox(height: 20),
                        rouletteScore(snapshot.data)
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}
