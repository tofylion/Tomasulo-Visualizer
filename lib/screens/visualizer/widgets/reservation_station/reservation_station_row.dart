import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/reservation_station/reservation_station_element_view_model.dart';

class ReservationStationRow extends ConsumerWidget {
  const ReservationStationRow(
      {super.key, required this.elementId, this.isAu = false});

  final String elementId;
  final bool isAu;

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
          elementId.toUpperCase(),
          // key: ValueKey(elementId),
          style: AppTextStyles.dp20EgyptianBlue,
        ),
        Text(
          busyText(item),
          // key: ValueKey(busyText(item)),
          style: AppTextStyles.dp20EgyptianBlue,
        ),
        Text(
          itemName(item, instruction),
          // key: ValueKey(itemName(item, instruction)),
          style: AppTextStyles.dp20EgyptianBlue,
        ),
        if (!isAu)
          textWidget(
              item.busy ? instruction?.operand1Val.toString() ?? 'X' : 'X'),
        if (!isAu)
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
      // key: ValueKey(text),
      children: [
        AutoSizeText(text, style: AppTextStyles.dp16BlackShadow),
        AutoSizeText(text, style: AppTextStyles.dp16Yellow),
      ],
    );
  }

  String itemName(ReservationStationElement item, Instruction? instruction) =>
      item.busy ? instruction?.type.name.toUpperCase() ?? 'X' : 'X';
  String busyText(ReservationStationElement item) => item.busy ? '1' : '0';
}
