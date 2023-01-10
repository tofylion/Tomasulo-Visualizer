import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/molecules/tappable.dart';
import 'package:tomasulo_viz/constants/app_styles.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';

class CTAButton extends StatelessWidget {
  const CTAButton({
    this.text = '',
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: AppStyles.CTAButtonBackgroundColour,
            elevation: Dimensions.defaultButtonElevation,
            shape: Dimensions.defaultButtonShapeMaterial,
            fixedSize: Dimensions.defaultButtonSizeMaterial,
            splashFactory: NoSplash.splashFactory),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: Text(
            text,
            style: AppTextStyles.dp32Black,
          ),
        ),
      ),
    );
  }
}
