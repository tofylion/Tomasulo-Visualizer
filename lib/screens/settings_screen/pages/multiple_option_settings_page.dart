import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/screens/settings_screen/main/settings_view_model.dart';

class MultipleOptionSettingsPage<T extends Enum> extends ConsumerWidget {
  const MultipleOptionSettingsPage(
      {super.key,
      required this.configOption,
      required this.configNames,
      required this.configs});

  final List<T> configOption;
  final Map<T, String> configNames;
  final Map<T, int> configs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(SettingsViewModel.provider);
    return Padding(
      padding: EdgeInsets.only(left: 40.sp),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 52.sp, vertical: 100.sp),
          child: ListView.builder(
              itemCount: configOption.length,
              itemBuilder: (context, index) {
                final item = configOption.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (index != 0) SizedBox(height: 22.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          configNames[item]!,
                          style: AppTextStyles.dp42PowderBlue,
                        ),
                        TextFormField(
                          cursorColor: AppColours.egyptianBlue,
                          style: AppTextStyles.dp32Black,
                          textAlign: TextAlign.center,
                          initialValue: configs[item].toString(),
                          onChanged: (value) =>
                              vm.modifyConfig<T>(configs, value, item),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 9.sp),
                            alignLabelWithHint: true,
                            constraints: BoxConstraints(
                                maxHeight: 50.sp,
                                maxWidth: 100.sp,
                                minHeight: 50.sp,
                                minWidth: 100.sp),
                            filled: true,
                            isCollapsed: true,
                            fillColor: AppColours.lightBlue,
                            focusColor: AppColours.lightBlue,
                            hoverColor: AppColours.lightBlue,
                            border: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: Dimensions.defaultButtonRadius,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: Dimensions.defaultButtonRadius,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: Dimensions.defaultButtonRadius,
                            ),
                          ),
                        )
                        // Container(
                        //   alignment: Alignment.center,
                        //   height: 50.sp,
                        //   width: 100.sp,
                        //   decoration: BoxDecoration(
                        //     color: AppColours.lightBlue,
                        //     borderRadius: Dimensions.defaultButtonRadius,
                        //   ),
                        //   child: Text(
                        //     configs[item].toString(),
                        //     style: AppTextStyles.dp32Black,
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Container(
                      height: 0,
                      width: 800.sp,
                      decoration: BoxDecoration(
                          color: AppColours.black25,
                          border: Border.all(
                              color: AppColours.black25,
                              width: 3.sp,
                              strokeAlign: StrokeAlign.center)),
                    )
                  ],
                );
              })),
    );
  }
}
