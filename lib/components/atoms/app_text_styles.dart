import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';

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

  static TextStyle get dp64PowderBlue => _dp64PowderBlue;

  static TextStyle get dp32PowderBlue => _dp32PowderBlue;

  static TextStyle get dp32Black => _dp32Black;

  static TextStyle get dp32EgyptianBlue => _dp32EgyptianBlue;

  static TextStyle get dp42PowderBlue => _dp42PowderBlue;
}
