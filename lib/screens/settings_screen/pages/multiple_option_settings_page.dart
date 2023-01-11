import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/widgets/inputs/primary_number_input_field.dart';
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
                        PrimaryNumberInputField(
                          initialValue: configs[item].toString(),
                          onChanged: (value) =>
                              vm.modifyConfig<T>(configs, value, item),
                        )
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
