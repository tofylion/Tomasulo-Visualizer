import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/clock.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';

final clockProvider = ChangeNotifierProvider<Clock>((ref) => Clock());
final executionFinishedProvider = Provider<bool>((ref) {
  final clock = ref.watch(clockProvider);
  final addStation = ref.read(reservationStationProvider(AluStation.add));
  final multStation = ref.read(reservationStationProvider(AluStation.mult));
  final storeBuffer = ref.read(reservationStationProvider(AluStation.store));
  final loadBuffer = ref.read(reservationStationProvider(AluStation.load));
  final addressUnit =
      ref.read(reservationStationElementProvider(addressUnitId));
  return addStation.isEmpty() &&
      multStation.isEmpty() &&
      storeBuffer.isEmpty() &&
      loadBuffer.isEmpty() &&
      !addressUnit.busy &&
      clock.cycles != 0;
});
