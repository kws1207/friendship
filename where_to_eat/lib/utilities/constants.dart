// https://github.com/MarcusNg/flutter_login_ui/blob/master/lib/utilities/constants.dart
import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'BMYS',
);

final kBlackLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontFamily: 'BMDH',
  fontSize: 12,
);

final kWhiteLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontFamily: 'BMDH',
);

final kNameStyle = TextStyle(
  color: Colors.black,
  letterSpacing: 1.5,
  fontSize: 36.0,
  fontWeight: FontWeight.normal,
  fontFamily: 'BMYS',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.orange[100],
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kImageShadowStyle = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black45,
      blurRadius: 10.0,
      offset: Offset(2, 4),
    ),
  ],
);
