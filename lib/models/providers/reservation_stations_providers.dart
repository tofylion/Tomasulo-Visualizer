import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/models/operation_station.dart';
import 'package:tomasulo_viz/models/providers/memory_provider.dart';
import 'package:tomasulo_viz/models/providers/registers_providers.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';
import 'package:tuple/tuple.dart';

enum AluStation { add, mult, load, store }

final reservationStationProvider =
    Provider.family<ReservationStation, AluStation>((ref, stationType) {
  final registers = ref.read(registerFileProvider);
  final config = ref.read(AppConfig.provider);
  final memory = ref.read(memoryProvider);
  switch (stationType) {
    case AluStation.add:
      return ReservationStation.add(
        registers: registers,
        size: config.rsSizes[RSSizesConfig.add]!,
        funitSize: config.fuSizes[FUSizesConfig.adders]!,
        funitDelay: config.cycles[CycleConfig.add]!,
      );
    case AluStation.mult:
      return ReservationStation.mult(
        registers: registers,
        size: config.rsSizes[RSSizesConfig.mult]!,
        funitSize: config.fuSizes[FUSizesConfig.multipliers]!,
        funitDelay: config.cycles[CycleConfig.mult]!,
      );
    case AluStation.load:
      return MemoryBuffer.load(
          functionalUnit: memory,
          registers: registers,
          size: config.rsSizes[RSSizesConfig.load]!);
    case AluStation.store:
      return MemoryBuffer.store(
          functionalUnit: memory,
          registers: registers,
          size: config.rsSizes[RSSizesConfig.store]!);
  }
});

const addressUnitId = 'au';
const addIdPrefix = 'a';
const multIdPrefix = 'm';
const loadIdPrefix = 'l';
const storeIdPrefix = 's';

final reservationStationElementProvider =
    ChangeNotifierProvider.family<ReservationStationElement, String>((ref, id) {
  final registerFile = ref.read(registerFileProvider);
  if (id.toLowerCase() == addressUnitId) {
    final loadBuffer =
        ref.read(reservationStationProvider(AluStation.load)) as MemoryBuffer;
    final storeBuffer =
        ref.read(reservationStationProvider(AluStation.store)) as MemoryBuffer;

    return AddressUnit(
        addressUnitId.toUpperCase(), registerFile, loadBuffer, storeBuffer);
  } else {
    late final ReservationStation station;
    switch (id.toLowerCase()[0]) {
      case addIdPrefix:
        station = ref.read(reservationStationProvider(AluStation.add));
        break;
      case multIdPrefix:
        station = ref.read(reservationStationProvider(AluStation.mult));
        break;
      case loadIdPrefix:
        station = ref.read(reservationStationProvider(AluStation.load));
        return (station as MemoryBuffer)
            .real_stations
            .firstWhere((element) => element.ID == id);
      case storeIdPrefix:
        station = ref.read(reservationStationProvider(AluStation.store));
        return (station as MemoryBuffer)
            .real_stations
            .firstWhere((element) => element.ID == id);
    }
    return station.stations.firstWhere((element) => element.ID == id);
  }
});

final operationStationProvider =
    Provider.family<OperationStation, AluStation>((ref, type) {
  final reservationStation = ref.watch(reservationStationProvider(type));
  return reservationStation.functionalUnit;
});
