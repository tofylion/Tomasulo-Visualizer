import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/widgets/buttons/cta_button.dart';
import 'package:tomasulo_viz/components/widgets/buttons/settings_tab_button.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/constants/app_timing.dart';
import 'package:tomasulo_viz/screens/settings_screen/constants/settings_tabs.dart';
import 'package:tomasulo_viz/screens/settings_screen/main/settings_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(SettingsViewModel.provider);
    return Scaffold(
      backgroundColor: AppColours.egyptianBlue,
      body: Row(
        children: [
          Container(
              width: 273.sp,
              height: 1.sh,
              color: AppColours.darkBlue,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: SettingsTab.values.length,
                      itemBuilder: (context, index) {
                        final thisTab = SettingsTab.values.elementAt(index);
                        return Column(
                          children: [
                            if (index == 0) SizedBox(height: 101.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: tabPadding(),
                                  child: SettingsTabButton(
                                    selected: vm.isTabSelected(thisTab),
                                    text: settingsTabNames[thisTab]!,
                                    onPressed: () => vm.changeTab(thisTab),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 150.sp,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CTAButton(
                          text: 'Back',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
              child: PageTransitionSwitcher(
            reverse: vm.reverseTabDirection,
            duration: AppTiming.transitionsDuration,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: animation,
                fillColor: Colors.transparent,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.vertical,
                child: child,
              );
            },
            child: vm.activeWidget ?? const SizedBox.shrink(),
          ))
        ],
      ),
    );
  }

  EdgeInsets tabPadding() => EdgeInsets.only(bottom: 23.sp);
}
