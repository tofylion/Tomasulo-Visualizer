import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_shadows.dart';

class AppTextStyles {
  static TextStyle get _baseStyle => TextStyle(
        fontFamily: "Fredoka One",
        letterSpacing: -0.04.sp,
        fontWeight: FontWeight.w400,
        height: 1.21,
      );

  static TextStyle get _dp64PowderBlue => _baseStyle.copyWith(
        fontSize: 64.sp,
        color: AppColours.powderBlue,
      );

  static TextStyle get _dp32PowderBlue => _baseStyle.copyWith(
        fontSize: 32.sp,
        color: AppColours.powderBlue,
      );

  static TextStyle get _dp32Black => _baseStyle.copyWith(
        fontSize: 32.sp,
        color: Colors.black,
      );

  static TextStyle get _dp32EgyptianBlue => _baseStyle.copyWith(
        fontSize: 32.sp,
        color: AppColours.egyptianBlue,
      );

  static TextStyle get _dp42PowderBlue => _baseStyle.copyWith(
        fontSize: 42.sp,
        color: AppColours.powderBlue,
      );
  static TextStyle get _dp36EgyptianBlue => _baseStyle.copyWith(
        fontSize: 36.sp,
        color: AppColours.egyptianBlue,
      );

  static TextStyle get _dp36Black => _baseStyle.copyWith(
        fontSize: 36.sp,
        color: Colors.black,
      );

  static TextStyle get _dp20Black => _baseStyle.copyWith(
        fontSize: 20.sp,
        color: Colors.black,
      );

  static TextStyle get _dp24Black => _baseStyle.copyWith(
        fontSize: 24.sp,
        color: Colors.black,
      );

  static TextStyle get _dp20LightBlue => _baseStyle.copyWith(
        fontSize: 20.sp,
        color: AppColours.lightBlue,
      );
  static TextStyle get _dp24LightBlue => _baseStyle.copyWith(
        fontSize: 24.sp,
        color: AppColours.lightBlue,
      );

  static TextStyle get _dp16EgyptianBlue => _baseStyle.copyWith(
        fontSize: 16.sp,
        color: AppColours.egyptianBlue,
      );

  static TextStyle get _dp20EgyptianBlue => _baseStyle.copyWith(
        fontSize: 20.sp,
        color: AppColours.egyptianBlue,
      );

  static TextStyle get _dp16YellowWithShadow => _baseStyle.copyWith(
        fontSize: 16.sp,
        color: AppColours.yellowBrickRoad,
        shadows: [AppShadows.textShadowDefault],
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.sp
          ..color = Colors.black,
      );

  static TextStyle get _dp20YellowWithShadow => _baseStyle.copyWith(
        fontSize: 20.sp,
        color: AppColours.yellowBrickRoad,
        shadows: [AppShadows.textShadowDefault],
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.sp
          ..color = Colors.black,
      );

  static TextStyle get _dp32YellowWithShadow => _baseStyle.copyWith(
        fontSize: 32.sp,
        color: AppColours.yellowBrickRoad,
        shadows: [AppShadows.textShadowDefault],
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.sp
          ..color = Colors.black,
      );
  static TextStyle get _dp16BlackWithShadow => _baseStyle.copyWith(
        fontSize: 16.sp,
        color: AppColours.black,
        shadows: [AppShadows.textShadowDefault],
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.sp
          ..color = Colors.black,
      );

  static TextStyle get _dp20BlackWithShadow => _baseStyle.copyWith(
        fontSize: 20.sp,
        color: AppColours.black,
        shadows: [AppShadows.textShadowDefault],
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.sp
          ..color = Colors.black,
      );

  static TextStyle get _dp32BlackWithShadow => _baseStyle.copyWith(
        fontSize: 32.sp,
        color: AppColours.black,
        shadows: [AppShadows.textShadowDefault],
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.sp
          ..color = Colors.black,
      );
  static TextStyle get dp64PowderBlue => _dp64PowderBlue;

  static TextStyle get dp32PowderBlue => _dp32PowderBlue;

  static TextStyle get dp32Black => _dp32Black;

  static TextStyle get dp36Black => _dp36Black;

  static TextStyle get dp20Black => _dp20Black;

  static TextStyle get dp24Black => _dp24Black;

  static TextStyle get dp32EgyptianBlue => _dp32EgyptianBlue;

  static TextStyle get dp42PowderBlue => _dp42PowderBlue;

  static TextStyle get dp36EgyptianBlue => _dp36EgyptianBlue;

  static TextStyle get dp20LightBlue => _dp20LightBlue;

  static TextStyle get dp24LightBlue => _dp24LightBlue;

  static TextStyle get dp16EgyptianBlue => _dp16EgyptianBlue;

  static TextStyle get dp20EgyptianBlue => _dp20EgyptianBlue;

  static TextStyle get dp16YellowWithShadow => _dp16YellowWithShadow;

  static TextStyle get dp20YellowWithShadow => _dp20YellowWithShadow;

  static TextStyle get dp32YellowWithShadow => _dp32YellowWithShadow;

  static TextStyle get dp16BlackWithShadow => _dp16BlackWithShadow;

  static TextStyle get dp20BlackWithShadow => _dp20BlackWithShadow;

  static TextStyle get dp32BlackWithShadow => _dp32BlackWithShadow;
}
