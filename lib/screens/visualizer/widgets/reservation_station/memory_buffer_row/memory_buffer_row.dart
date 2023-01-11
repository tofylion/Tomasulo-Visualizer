import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/reservation_station/reservation_station_element_view_model.dart';

class MemoryBufferRow extends ConsumerWidget {
  const MemoryBufferRow({super.key, required this.elementId});

  final String elementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm =
        ref.watch(ReservationStationElementViewModel.provider(elementId));
    final item = vm.element as MemoryOperationElement;
    return SizedBox(
      width: 90.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            elementId,
            style: AppTextStyles.dp16EgyptianBlue,
          ),
          SizedBox(
            width: 12.sp,
          ),
          Text(
            item.busy ? '1' : '0',
            style: AppTextStyles.dp16EgyptianBlue,
          ),
          SizedBox(
            width: 18.sp,
          ),
          Stack(
            children: [
              AutoSizeText(
                  (item.currentInstruction?.addressOffset ??
                          0 +
                              (item.currentInstruction?.operand2Val.toInt() ??
                                  0))
                      .toString(),
                  style: AppTextStyles.dp16BlackShadow),
              AutoSizeText(
                  (item.currentInstruction?.addressOffset ??
                          0 +
                              (item.currentInstruction?.operand2Val.toInt() ??
                                  0))
                      .toString(),
                  style: AppTextStyles.dp16Yellow),
            ],
          )
        ],
      ),
    );
  }
}
