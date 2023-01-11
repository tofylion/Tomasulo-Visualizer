import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/models/operation_station.dart';

final memoryProvider = ChangeNotifierProvider<MemOperationStation>((ref) {
  final appConfig = ref.watch(AppConfig.provider);
  return MemOperationStation(
      memSize: appConfig.memorySize,
      delay: appConfig.cycles[CycleConfig.load]!);
});
