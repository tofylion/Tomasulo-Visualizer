import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/reservation_station/reservation_station_row.dart';

class ReservationStationWidget extends ConsumerStatefulWidget {
  const ReservationStationWidget({super.key, required this.stationType});

  final AluStation stationType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationStationWidgetState();
}

class _ReservationStationWidgetState
    extends ConsumerState<ReservationStationWidget> {
  final _controller = ScrollController();

  @override
  void initState() {
    assert(
        widget.stationType != AluStation.store &&
            widget.stationType != AluStation.load,
        "Silly, you can't do that!");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final memoryBuffer =
        ref.read(reservationStationProvider(widget.stationType));
    ref.watch(clockProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Scrollbar(
          controller: _controller,
          child: ListView.separated(
              controller: _controller,
              itemBuilder: (context, index) {
                final stationElements = memoryBuffer.stations;

                return ReservationStationRow(
                  elementId: stationElements[index].ID,
                );
              },
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 0.sp,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColours.black50,
                                  width: 1.sp,
                                  strokeAlign: StrokeAlign.center)),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: memoryBuffer.stations.length)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
