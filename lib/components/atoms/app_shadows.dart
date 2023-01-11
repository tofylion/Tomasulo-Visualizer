import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';

class AppShadows {
  static BoxShadow get shadowDefault4 =>
      BoxShadow(offset: Offset(0, 4.sp), color: AppColours.egyptianBlue);

  static BoxShadow get shadowDefault3 =>
      BoxShadow(offset: Offset(0, 3.sp), color: AppColours.egyptianBlue);
  static BoxShadow get shadowDark3 =>
      BoxShadow(offset: Offset(0, 3.sp), color: AppColours.darkBlue);
  static BoxShadow get shadowDefault2 =>
      BoxShadow(offset: Offset(0, 2.sp), color: AppColours.egyptianBlue);
  static Shadow get textShadowDefault =>
      Shadow(color: AppColours.black, offset: Offset(1.sp, 1.sp));
}
