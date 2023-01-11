import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/register_file/register_column/register_column_view_model.dart';

class RegisterColumn extends ConsumerWidget {
  const RegisterColumn({super.key, required this.registerId});

  final String registerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(RegisterColumnViewModel.provider(registerId));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          registerId,
          style: AppTextStyles.dp32EgyptianBlue,
        ),
        Stack(
          children: [
            Text(vm.register.opID ?? vm.register.value.toString(),
                style: AppTextStyles.dp32BlackShadow),
            Text(vm.register.opID ?? vm.register.value.toString(),
                style: AppTextStyles.dp32Yellow),
          ],
        )
      ],
    );
  }
}
