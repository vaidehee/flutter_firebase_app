import 'package:flutter/material.dart';
//this class holds color code  to all colors used in the application

class ColorAssets
{
  static const Color themeColorWhite = Color(0XFFffffff);
  static const Color themeColorBlack = Color(0XFF000000);
  static const Color themeColorPeach = Color(0XFFFBDAC7);
  static const Color themeColorPink =  Color(0XFFFBD7ED);
  static const Color themeColorLightPeach = Color(0XFFFEF6FA);
  static Color themeColorDarkPink =  Colors.pinkAccent.withOpacity(0.5);

  List<Color> bgGradients = [
     Color(0XFFFBD7ED),
     Color(0XFFFCDFD3),
  ];
   List<Color> themeGradients = [
     Color(0XFFFEF6FA),
     Color(0XFFFBDAC7),
  ];
}