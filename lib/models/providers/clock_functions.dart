import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';
import 'package:tomasulo_viz/models/providers/instruction_queue_provider.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';

void initClockListeners(WidgetRef ref) {
  final clock = ref.read(clockProvider);
  final instructions = ref.read(instructionQueueProvider);
  final addStation = ref.read(reservationStationProvider(AluStation.add));
  final multStation = ref.read(reservationStationProvider(AluStation.mult));
  final addressUnit =
      ref.read(reservationStationElementProvider(addressUnitId)) as AddressUnit;
  final storeBuffer = ref.read(reservationStationProvider(AluStation.store));
  final loadBuffer = ref.read(reservationStationProvider(AluStation.load));

  clock.addListener(() {
    instructions.onClockTick(clock.cycles);
    addStation.onClockTick(clock.cycles);
    multStation.onClockTick(clock.cycles);
    addressUnit.onClockTick();
    storeBuffer.onClockTick(clock.cycles);
    loadBuffer.onClockTick(clock.cycles);
  });
}
