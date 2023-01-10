import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CycleConfig { add, mult, sub, div, load, store }

const Map<CycleConfig, String> cycleConfigNames = {
  CycleConfig.add: 'ADD Clock Cycles',
  CycleConfig.sub: 'SUB Clock Cycles',
  CycleConfig.mult: 'MULT Clock Cycles',
  CycleConfig.div: 'DIV Clock Cycles',
  CycleConfig.load: 'LW Clock Cycles',
  CycleConfig.store: 'SW Clock Cycles',
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

class AppConfig extends ChangeNotifier {
  Map<CycleConfig, int> cycles = {
    for (CycleConfig v in CycleConfig.values) v: 1
  };

  Map<RSSizesConfig, int> rsSizes = {
    for (RSSizesConfig v in RSSizesConfig.values) v: 1
  };

  Map<FUSizesConfig, int> fuSizes = {
    for (FUSizesConfig v in FUSizesConfig.values) v: 1
  };

  void modifyConfig<T extends Enum>(
      Map<T, int> configMap, T configOption, int value) {
    configMap[configOption] = value;
    notifyListeners();
  }

  int memorySize = 10;
  int auSize = 10;

  static final provider =
      ChangeNotifierProvider<AppConfig>((ref) => AppConfig());
}
