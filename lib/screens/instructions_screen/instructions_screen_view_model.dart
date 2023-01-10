import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstructionsScreenViewModel extends ChangeNotifier {
  InstructionsScreenViewModel();
  final List<String> registers = ['F1', 'F2', 'F3', 'F4'];

  String _selectedRegister = 'F1';
  String get selectedRegister => _selectedRegister;

  set selectedRegister(String val) {
    _selectedRegister = val;
    notifyListeners();
  }

  static final provider = ChangeNotifierProvider<InstructionsScreenViewModel>(
      (ref) => InstructionsScreenViewModel());
}
