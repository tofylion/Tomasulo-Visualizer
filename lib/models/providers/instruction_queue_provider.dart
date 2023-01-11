import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';

final instructionQueueProvider =
    ChangeNotifierProvider<InstructionQueue>((ref) {
  final config = ref.read(AppConfig.provider);
  final addStation = ref.read(reservationStationProvider(AluStation.add));
  final multStation = ref.read(reservationStationProvider(AluStation.mult));
  final addressUnit =
      ref.read(reservationStationElementProvider(addressUnitId)) as AddressUnit;
  return InstructionQueue(
      config.instructions, addStation, multStation, addressUnit);
});
