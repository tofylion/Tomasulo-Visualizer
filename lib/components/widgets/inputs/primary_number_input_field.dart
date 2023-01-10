import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';

class PrimaryNumberInputField extends StatelessWidget {
  const PrimaryNumberInputField(
      {super.key, this.initialValue, this.onChanged, this.width, this.height});

  final String? initialValue;
  final void Function(String value)? onChanged;

  ///default = 100.sp
  final double? width;

  ///default = 50.sp
  final double? height;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColours.egyptianBlue,
      style: AppTextStyles.dp32Black,
      textAlign: TextAlign.center,
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 9.sp),
        alignLabelWithHint: true,
        constraints: BoxConstraints(
            maxHeight: height ?? 50.sp,
            maxWidth: width ?? 100.sp,
            minHeight: height ?? 50.sp,
            minWidth: width ?? 100.sp),
        filled: true,
        isCollapsed: true,
        fillColor: AppColours.lightBlue,
        focusColor: AppColours.lightBlue,
        hoverColor: AppColours.lightBlue,
        border: OutlineInputBorder(
          gapPadding: 0,
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          borderRadius: Dimensions.defaultButtonRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          borderRadius: Dimensions.defaultButtonRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          borderRadius: Dimensions.defaultButtonRadius,
        ),
      ),
    );
  }
}
