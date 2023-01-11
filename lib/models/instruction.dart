import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';

// do not edit
class Instruction {
  final InstructionType _type;
  InstructionType get type => _type;
  String? target;
  String? operand1Reg;
  String? operand2Reg;
  String? operand1ID;
  String? operand2ID;
  double operand1Val = 0;
  double operand2Val = 0;
  int? addressOffset;
  int? issueCycle;
  int? startOperationCycle;
  int? endOperationCycle;
  int? writeBackOperationCycle;

  Instruction.add(
      {required this.target,
      required this.operand1Reg,
      required this.operand2Reg})
      : _type = InstructionType.add;
  Instruction.sub(
      {required this.target,
      required this.operand1Reg,
      required this.operand2Reg})
      : _type = InstructionType.sub;
  Instruction.mult(
      {required this.target,
      required this.operand1Reg,
      required this.operand2Reg})
      : _type = InstructionType.mult;
  Instruction.div(
      {required this.target,
      required this.operand1Reg,
      required this.operand2Reg})
      : _type = InstructionType.div;
  Instruction.load(
      {required this.target,
      required this.operand2Reg,
      required this.addressOffset})
      : _type = InstructionType.load;
  Instruction.store(
      {required this.operand1Reg,
      required this.operand2Reg,
      required this.addressOffset})
      : _type = InstructionType.store;
  @override
  String toString() {
    return ('type : $type , target :$target, v1 : $operand1Val, v2 : $operand2Val, o1: $operand1ID, o2: $operand2ID');
  }
}

class InstructionQueue extends ChangeNotifier {
  final List<Instruction> instructions = <Instruction>[];
  int index = 0;
  ReservationStation add;
  ReservationStation mult;
  AddressUnit addressUnit;

  InstructionQueue(List<Instruction> l, this.add, this.mult, this.addressUnit) {
    instructions.addAll(l);
  }
  bool issueInstruction(Instruction i) {
    return add.allocate(i) || mult.allocate(i) || addressUnit.allocate(i);
  }

  void onClockTick(int clockCycle) {
    if (!finished && !addressUnit.busy) {
      if (issueInstruction(currentInstruction!)) {
        currentInstruction!.issueCycle = clockCycle;
        index++;
      }

      notifyListeners();
    }
  }

  Instruction? get currentInstruction {
    if (!finished) {
      return instructions[index];
    } else {
      return null;
    }
  }

  bool get finished => index >= instructions.length;
}

enum InstructionType { add, sub, mult, div, load, store }
