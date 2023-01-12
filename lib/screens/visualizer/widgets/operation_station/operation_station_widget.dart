import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/models/operation_station.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';

class OperationStationWidget extends ConsumerWidget {
  const OperationStationWidget(
      {super.key, required this.name, required this.type});

  final String name;
  final AluStation type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final station = ref.watch(operationStationProvider(type));
    ref.watch(clockProvider);
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(name, style: AppTextStyles.dp32EgyptianBlue),
        Positioned(
            bottom: 5.sp,
            right: 5.sp,
            child: Text(
              "${countBusyStations(station.stations)}/${station.stations.length}",
              style: AppTextStyles.dp16EgyptianBlue,
            ))
      ],
    );
  }

  int countBusyStations(List<OperationStationElement> elements) {
    int busyStations = 0;
    for (final element in elements) {
      busyStations += element.busy ? 1 : 0;
    }
    return busyStations;
  }
}
