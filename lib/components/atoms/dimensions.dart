import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimensions {
  static MaterialStateProperty<double?> get defaultButtonElevation =>
      MaterialStateProperty.resolveWith<double?>((states) {
        if (states.contains(MaterialState.hovered) &&
            !states.contains(MaterialState.pressed)) {
          return 10.sp;
        } else {
          return 0;
        }
      });

  static Size get defaultButtonSize => Size(200.sp, 50.sp);
  static Size get enlargedButtonSize => Size(240.sp, 60.sp);
  static Size get minButtonSize => Size(120.sp, 50.sp);

  static MaterialStateProperty<Size?> get defaultButtonSizeMaterial =>
      MaterialStateProperty.all<Size?>(
        defaultButtonSize,
      );
  static OutlinedBorder get defaultButtonShape =>
      RoundedRectangleBorder(borderRadius: defaultButtonRadius);
  static BorderRadius get defaultButtonRadius => BorderRadius.circular(10.sp);
  static MaterialStateProperty<OutlinedBorder> get defaultButtonShapeMaterial =>
      MaterialStateProperty.all(defaultButtonShape);
}
