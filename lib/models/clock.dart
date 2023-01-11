import 'package:flutter/cupertino.dart';

class Clock extends ChangeNotifier {
  int cycles = 0;

  Clock();

  void onClockTick() {
    cycles++;
    notifyListeners();
  }

  // bool finished() {
  //   bool f = instructions.index < instructions.intructions.length &&
  //       addStation.isEmpty() &&
  //       multStation.isEmpty() &&
  //       storeBuffer.isEmpty() &&
  //       loadBuffer.isEmpty() &&
  //       !addressUnit.busy;
  //   notifyListeners();
  //   return f;
  // }

  // void runToFinish() {
  //   while (!finished()) {
  //     onClockTick();
  //   }
  // }
}
