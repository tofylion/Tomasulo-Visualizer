import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprung/sprung.dart';
import 'package:tomasulo_viz/components/atoms/app_shadows.dart';
import 'package:tomasulo_viz/components/molecules/tappable.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/constants/app_styles.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/constants/app_timing.dart';

class SettingsTabButton extends StatelessWidget {
  const SettingsTabButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.selected = false,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      fadeInDuration: AppTiming.transitionsDuration,
      child: AnimatedContainer(
        curve: Sprung.criticallyDamped,
        duration: AppTiming.transitionsDuration,
        width: selected
            ? Dimensions.enlargedButtonSize.width
            : Dimensions.defaultButtonSize.width,
        height: selected
            ? Dimensions.enlargedButtonSize.height
            : Dimensions.defaultButtonSize.height,
        decoration: BoxDecoration(
          boxShadow: selected
              ? [AppShadows.shadowDefault3]
              : [AppShadows.shadowDefault2],
          borderRadius: Dimensions.defaultButtonRadius,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: AppStyles.secondaryButtonBackgroundColour,
              shape: Dimensions.defaultButtonShapeMaterial,
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              fixedSize: Dimensions.defaultButtonSizeMaterial,
              splashFactory: NoSplash.splashFactory),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: Text(
              text,
              style: AppTextStyles.dp32EgyptianBlue,
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}
