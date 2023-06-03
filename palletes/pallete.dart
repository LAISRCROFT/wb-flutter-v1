import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor WBColor = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff7a22a7), //10%
      100: Color(0xff000000), //20%
      200: Color(0xffe0e0e0), //30%
      300: Color(0xff696969), //40%
      400: Color(0xff373737), //40%
      500: Color(0xffe7d233), //100%
      600: Color(0xffffffff), //100%
    },
  );
}
