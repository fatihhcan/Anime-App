import 'package:anime_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  //Unique Colors
  Color mirage = '1a252b'.color;
  Color shark = '1C1C1D'.color;
  Color white = 'FFFFFF'.color;
  Color trinidad = 'E04D01'.color;

  //Overrided Colors
  late Color scaffoldBackgroundColor;
}

class LightColors extends AppColors {
  @override
  Color get scaffoldBackgroundColor => mirage;
  Color get headLineTextColor => white;
  Color get appBarTextColor => white;
}

class DarkColors extends AppColors {
  @override
  Color get scaffoldBackgroundColor => shark;
  Color get headLineTextColor => white;
  Color get appBarTextColor => white;
}
