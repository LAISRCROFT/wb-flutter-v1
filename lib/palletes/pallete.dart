import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor WBColor = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff7a22a7), //10%
      100: Color(0xff000000), //20%
      200: Color(0xffe0e0e0), //30%
      300: Color(0xff696969), //40%
      350: Color(0xff989898), //40%
      400: Color(0xff373737), //40%
      500: Color(0xffe7d233), //100%
      600: Color(0xffffffff), //100%
      700: Color(0xffcecece), //100%
      800: Color(0xfff0f0f0), //100%
    },
  );
  static const Color WBColorShade50 = Color(0xff7a22a7);
  static const Color WBColorShade100 = Color(0xff000000);
  static const Color WBColorShade200 = Color(0xffe0e0e0);
  static const Color WBColorShade300 = Color(0xff696969);
  static const Color WBColorShade400 = Color(0xff373737);
  static const Color WBColorShade500 = Color(0xffe7d233);
  static const Color WBColorShade600 = Color(0xffffffff);
  static const Color WBColorShade700 = Color(0xffcecece);
  static const Color WBColorShade800 = Color(0xfff0f0f0);
}
