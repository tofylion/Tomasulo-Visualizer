import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/reservation_station/reservation_station_element_view_model.dart';

class ReservationStationRow extends ConsumerWidget {
  const ReservationStationRow({super.key, required this.elementId});

  final String elementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm =
        ref.watch(ReservationStationElementViewModel.provider(elementId));
    final item = vm.element;
    final instruction = item.currentInstruction;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          elementId,
          style: AppTextStyles.dp20EgyptianBlue,
        ),
        Text(
          item.busy ? '1' : '0',
          style: AppTextStyles.dp20EgyptianBlue,
        ),
        Text(
          instruction?.type.name.toUpperCase() ?? 'X',
          style: AppTextStyles.dp20EgyptianBlue,
        ),
        textWidget(
            item.busy ? instruction?.operand1Val.toString() ?? 'X' : 'X'),
        textWidget(
            item.busy ? instruction?.operand2Val.toString() ?? 'X' : 'X'),
        textWidget(
            item.busy ? (instruction?.operand1ID ?? '0').toString() : 'X'),
        textWidget(
            item.busy ? (instruction?.operand2ID ?? '0').toString() : 'X'),
      ],
    );
  }

  Widget textWidget(String text) {
    return Stack(
      children: [
        AutoSizeText(text, style: AppTextStyles.dp16BlackShadow),
        AutoSizeText(text, style: AppTextStyles.dp16Yellow),
      ],
    );
  }
}
