import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/components/widgets/buttons/cta_button.dart';
import 'package:tomasulo_viz/constants/app_styles.dart';
import 'package:tomasulo_viz/screens/instructions_screen/instructions_screen_view_model.dart';

class InstructionsScreen extends ConsumerWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(InstructionsScreenViewModel.provider);
    return Scaffold(
      backgroundColor: AppColours.darkBlue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
                child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 204.sp, horizontal: 58.sp),
              child: Padding(
                padding: EdgeInsets.only(right: 122.sp, left: 63.sp),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 150.sp,
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: AppColours.lightBlue,
                            borderRadius: Dimensions.defaultButtonRadius,
                          ),
                          child: Center(
                            child: Text(
                              'ADD',
                              style: AppTextStyles.dp32EgyptianBlue,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        PrimaryDropDown(
                          value: vm.selectedRegister,
                          items: vm.registers,
                          onChanged: (value) {
                            if (value != null) {
                              vm.selectedRegister = value;
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          ),
          Positioned(
              bottom: 59.sp,
              right: 48.sp,
              child: CTAButton(
                text: 'Next',
                onPressed: () => DoNothingAction(),
              ))
        ],
      ),
    );
  }
}

class PrimaryDropDown extends StatelessWidget {
  const PrimaryDropDown({
    Key? key,
    this.value,
    this.items,
    this.onChanged,
  }) : super(key: key);

  final String? value;
  final List<String?>? items;
  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          dropdownDecoration: BoxDecoration(
            color: AppColours.lightBlue,
            borderRadius: Dimensions.defaultButtonRadius,
          ),
          buttonElevation: 0,
          dropdownElevation: 0,
          dropdownPadding: EdgeInsets.zero,
          buttonSplashColor: Colors.transparent,
          itemSplashColor: Colors.transparent,
          customButton: Container(
            width: 100.sp,
            height: 50.sp,
            decoration: BoxDecoration(
              color: AppColours.lightBlue,
              borderRadius: Dimensions.defaultButtonRadius,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    value ?? '',
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleDown,
                    size: 25.sp,
                    color: AppColours.egyptianBlue,
                  ),
                ]),
          ),
          dropdownOverButton: true,
          selectedItemHighlightColor: AppColours.mint,
          buttonHeight: 50.sp,
          buttonWidth: 100.sp,
          isDense: true,
          style: AppTextStyles.dp32EgyptianBlue,
          value: value,
          selectedItemBuilder: (context) {
            return [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Baseline(
                      baseline: 35.sp,
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        value ?? '',
                        style: AppTextStyles.dp32EgyptianBlue,
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          items: items
                  ?.map((e) => DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        child: Text(e ?? ''),
                        value: e,
                      ))
                  .toList() ??
              [],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
