import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomasulo_viz/components/widgets/buttons/cta_button.dart';
import 'package:tomasulo_viz/components/widgets/buttons/secondary_button.dart';
import 'package:tomasulo_viz/constants/app_assets.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/screens/instructions_screen/instructions_screen.dart';
import 'package:tomasulo_viz/screens/settings_screen/main/settings_screen.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColours.egyptianBlue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppAssets.landingBackground,
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topRight,
          ),
          Positioned.fill(
            top: 0.5.sh,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'By: Team 1 ©2023',
                    style: AppTextStyles.dp32PowderBlue,
                  ),
                  SizedBox(
                    height: 115.sp,
                  ),
                  CTAButton(
                    text: 'Start',
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const InstructionsScreen();
                    })),
                  ),
                  SizedBox(
                    height: 26.sp,
                  ),
                  SecondaryButton(
                    text: 'Options',
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SettingsScreen();
                    })),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
