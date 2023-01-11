import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/instruction.dart';

enum CycleConfig { add, mult, load }

const Map<CycleConfig, String> cycleConfigNames = {
  CycleConfig.add: 'ADDER Clock Cycles',
  CycleConfig.mult: 'MULTIPLIER Clock Cycles',
  CycleConfig.load: 'MEMORY Clock Cycles',
};

enum RSSizesConfig { add, mult, load, store }

const Map<RSSizesConfig, String> rsSizesConfigNames = {
  RSSizesConfig.add: 'ADD Station Size',
  RSSizesConfig.mult: 'MULT Station Size',
  RSSizesConfig.load: 'LOAD Station Size',
  RSSizesConfig.store: 'STORE Station Size',
};

enum FUSizesConfig { adders, multipliers, memory }

const Map<FUSizesConfig, String> fuSizesConfigNames = {
  FUSizesConfig.adders: 'Number of ADDERS',
  FUSizesConfig.multipliers: 'Number of MULTIPLIERS',
  FUSizesConfig.memory: 'Number of MEMORY units'
};

const String memorySizeConfigName = 'MEMORY Size';

class AppConfig extends ChangeNotifier {
  Map<CycleConfig, int> cycles = {
    for (CycleConfig v in CycleConfig.values) v: 10
  };

  Map<RSSizesConfig, int> rsSizes = {
    for (RSSizesConfig v in RSSizesConfig.values) v: 10
  };

  Map<FUSizesConfig, int> fuSizes = {
    for (FUSizesConfig v in FUSizesConfig.values) v: 10
  };

  void modifyConfig<T extends Enum>(
      Map<T, int> configMap, T configOption, int value) {
    configMap[configOption] = value;
    notifyListeners();
  }

  void modifyMemorySize(int value) {
    memorySize = value;
    notifyListeners();
  }

  int memorySize = 100;

  List<Instruction> instructions = [];

  static final provider =
      ChangeNotifierProvider<AppConfig>((ref) => AppConfig());
}
