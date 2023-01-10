import 'package:flutter/material.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';

class AppStyles {
  static MaterialStateProperty<Color?> get CTAButtonBackgroundColour =>
      MaterialStateProperty.all<Color>(AppColours.yellowBrickRoad);
  static ButtonStyle get baseButtonStyle => ButtonStyle(
      elevation: Dimensions.defaultButtonElevation,
      shape: Dimensions.defaultButtonShapeMaterial,
      splashFactory: NoSplash.splashFactory);
  static MaterialStateProperty<Color?> get secondaryButtonBackgroundColour =>
      MaterialStateProperty.all<Color>(AppColours.lightBlue);
}
