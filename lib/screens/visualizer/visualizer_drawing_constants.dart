import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class VizDConstants {
  static Size get ALUSize => Size(364.sp, 61.sp);
  static double get ALUBottom => 1.sh / 2;
  static double get ALUleft => 44.sp;

  static Size get RSSize => Size(370.sp, 200.sp);
  static double get RSBottom => 1.sh - 127.sp;
  static double get RSAddRight => 1.sw - 407.sp;
  static double get RSMultRight => 1.sw - 20.sp;

  static Size get FUSize => Size(300.sp, 61.sp);
  static double get FUBottom => 1.sh - 44.sp;
  static double get FPAdderRight => 1.sw - (364.sp - 24.sp);
  static double get FPMultRight => 1.sw - 20.sp;

  static Size get memoryBufferSize => Size(110.sp, 200.sp);
  static double get memoryBufferBottom => 1.sh - 127.sp;
  static double get loadLeft => 44.sp;
  static double get storeLeft => 176.sp;

  static Size get memorySize => Size(364.sp, 61.sp);
  static double get memoryBotom => 1.sh - 44.sp;
  static double get memoryLeft => 44.sp;

  static Size get regFileSize => Size(626.sp, 122.sp);
  static double get regFileBottom => 1.sh / 2;
  static double get regFileRight => 1.sw - 20.sp;

  static double get leftBus => 23.sp;
  static double get bottomBus => 1.sh - 19.sp;
  static double get rightBus => 1.sw - 3.sp;
}
