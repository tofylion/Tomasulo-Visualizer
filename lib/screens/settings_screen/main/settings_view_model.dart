import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/screens/settings_screen/constants/settings_tabs.dart';
import 'package:tomasulo_viz/screens/settings_screen/controller/settings_screen_controller.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel({required controller, required this.config}) {
    _controller = controller;
  }

  late SettingsScreenController _controller;
  final AppConfig config;

  Widget? get activeWidget => _controller.activeWidget;
  bool get reverseTabDirection => _controller.reverseTabDirection;

  static final provider = ChangeNotifierProvider<SettingsViewModel>((ref) {
    final controller = ref.read(SettingsScreenController.provider);
    final config = ref.watch(AppConfig.provider);
    return SettingsViewModel(controller: controller, config: config);
  });

  void changeTab(SettingsTab tab) {
    _controller.activeTab = tab;
    refreshScreen();
  }

  bool isTabSelected(SettingsTab tab) => _controller.activeTab == tab;

  void modifyConfig<T extends Enum>(
      Map<T, int> configMap, String? value, T configOption) {
    int? newValue = int.tryParse(value ?? '');
    if (value?.isEmpty ?? true) {
      newValue = 0;
    }
    if (newValue != null) {
      config.modifyConfig<T>(configMap, configOption, newValue);
    }
  }

  void modifyMemorySize(String? value) {
    int? newValue = int.tryParse(value ?? '');
    if (value?.isEmpty ?? true) {
      newValue = 0;
    }
    if (newValue != null) {
      config.modifyMemorySize(newValue);
    }
  }

  void refreshScreen() {
    notifyListeners();
  }
}
