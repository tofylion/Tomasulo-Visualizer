import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';

import 'memory_buffer_row/memory_buffer_row.dart';

class MemoryBufferWidget extends ConsumerStatefulWidget {
  const MemoryBufferWidget({super.key, required this.stationType});

  final AluStation stationType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<MemoryBufferWidget> {
  final _controller = ScrollController();

  @override
  void initState() {
    assert(
        widget.stationType == AluStation.store ||
            widget.stationType == AluStation.load,
        "Silly, you can't do that!");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final memoryBuffer = ref
        .read(reservationStationProvider(widget.stationType)) as MemoryBuffer;
    ref.watch(clockProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.sp),
      child: Scrollbar(
          controller: _controller,
          child: ListView.separated(
              controller: _controller,
              itemBuilder: (context, index) {
                final stationElements = memoryBuffer.real_stations;

                return MemoryBufferRow(
                  elementId: stationElements[index].ID,
                );
              },
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              separatorBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 9.sp, horizontal: 13.sp),
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
              itemCount: memoryBuffer.real_stations.length)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
