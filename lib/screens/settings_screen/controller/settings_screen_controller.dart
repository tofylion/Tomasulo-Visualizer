import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/screens/settings_screen/constants/settings_tabs.dart';
import 'package:tomasulo_viz/screens/settings_screen/pages/multiple_option_settings_page.dart';

class SettingsScreenController {
  SettingsScreenController({required this.config});

  late Map<SettingsTab, Widget> tabs = {
    SettingsTab.clockCycles: MultipleOptionSettingsPage(
      configOption: CycleConfig.values,
      configNames: cycleConfigNames,
      configs: config.cycles,
    ),
    SettingsTab.RSSizes: MultipleOptionSettingsPage(
      configOption: RSSizesConfig.values,
      configNames: rsSizesConfigNames,
      configs: config.rsSizes,
    ),
    SettingsTab.FUSizes: MultipleOptionSettingsPage(
      configOption: FUSizesConfig.values,
      configNames: fuSizesConfigNames,
      configs: config.fuSizes,
    ),
  };

  bool _reverseTabDirection = false;
  bool get reverseTabDirection => _reverseTabDirection;

  SettingsTab _activeTab = SettingsTab.clockCycles;

  Widget? get activeWidget => tabs[_activeTab];

  SettingsTab get activeTab => _activeTab;
  set activeTab(SettingsTab tab) {
    if (tabs.keys.toList().indexOf(tab) >
        tabs.keys.toList().indexOf(_activeTab)) {
      _reverseTabDirection = false;
    } else {
      _reverseTabDirection = true;
    }

    _activeTab = tab;
  }

  AppConfig config;

  static final provider = Provider<SettingsScreenController>((ref) {
    final config = ref.read(AppConfig.provider);
    return SettingsScreenController(config: config);
  });
}
