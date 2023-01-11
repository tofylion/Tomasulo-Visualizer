import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/exceptions/custom_exceptions.dart';
import 'package:tomasulo_viz/models/clock.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';

class VisualizerScreenViewModel extends ChangeNotifier {
  VisualizerScreenViewModel({required this.clock});

  final Clock clock;
  static final provider =
      ChangeNotifierProvider<VisualizerScreenViewModel>((ref) {
    final clock = ref.read(clockProvider);
    return VisualizerScreenViewModel(clock: clock);
  });

  void clockTick(BuildContext context) {
    try {
      clock.onClockTick();
    } on DivisionByZeroException catch (e) {
      const snackBar = SnackBar(content: Text("Division by zero :("));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
