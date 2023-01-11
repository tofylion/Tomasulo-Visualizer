import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/widgets/inputs/primary_number_input_field.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/screens/settings_screen/main/settings_view_model.dart';

class MemorySizePage extends ConsumerWidget {
  const MemorySizePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(SettingsViewModel.provider);
    return Padding(
      padding: EdgeInsets.only(left: 40.sp),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 52.sp, vertical: 100.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  memorySizeConfigName,
                  style: AppTextStyles.dp42PowderBlue,
                ),
                PrimaryNumberInputField(
                  initialValue: vm.config.memorySize.toString(),
                  onChanged: (value) => vm.modifyMemorySize(value),
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
        ),
      ),
    );
  }
}
