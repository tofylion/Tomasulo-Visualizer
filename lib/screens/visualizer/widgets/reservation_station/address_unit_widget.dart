import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/reservation_station/reservation_station_row.dart';

class AddressUnitWidget extends ConsumerWidget {
  const AddressUnitWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
      child: const ReservationStationRow(
        elementId: addressUnitId,
        isAu: true,
      ),
    );
  }
}
