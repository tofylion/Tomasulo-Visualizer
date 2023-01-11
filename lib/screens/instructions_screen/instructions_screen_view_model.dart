import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/models/providers/registers_providers.dart';

class InstructionsScreenViewModel extends ChangeNotifier {
  InstructionsScreenViewModel({required this.registers});
  final List<String> registers;

  final List<Instruction> _instructions = [];
  List<Instruction> get instructions => _instructions;

  static final provider =
      ChangeNotifierProvider<InstructionsScreenViewModel>((ref) {
    final registerFile = ref.read(registerFileProvider);
    final registerList =
        registerFile.registers.entries.map((entry) => entry.key).toList();
    registerList.sort();
    return InstructionsScreenViewModel(registers: registerList);
  });

  void reorderInstructions(int oldIndex, int newIndex) {
    final item = instructions.removeAt(oldIndex);
    if (newIndex > oldIndex) {
      instructions.insert(newIndex - 1, item);
    } else {
      instructions.insert(newIndex, item);
    }
    notifyListeners();
  }

  void removeInstruction(int index) {
    _instructions.removeAt(index);
    notifyListeners();
  }

  void createInstruction(InstructionType type) {
    final target = registers[Random().nextInt(registers.length)];
    final operand1Reg = registers[Random().nextInt(registers.length)];
    final operand2Reg = registers[Random().nextInt(registers.length)];
    late Instruction instruction;

    switch (type) {
      case InstructionType.add:
        instruction = Instruction.add(
            target: target, operand1Reg: operand1Reg, operand2Reg: operand2Reg);
        break;
      case InstructionType.sub:
        instruction = Instruction.sub(
            target: target, operand1Reg: operand1Reg, operand2Reg: operand2Reg);
        break;
      case InstructionType.mult:
        instruction = Instruction.mult(
            target: target, operand1Reg: operand1Reg, operand2Reg: operand2Reg);
        break;
      case InstructionType.div:
        instruction = Instruction.div(
            target: target, operand1Reg: operand1Reg, operand2Reg: operand2Reg);
        break;
      case InstructionType.load:
        instruction = Instruction.load(
            target: target,
            operand2Reg: operand2Reg,
            addressOffset: Random().nextInt(
                100)); //TODO: change 100 with memory address - operand2RegValue
        break;
      case InstructionType.store:
        instruction = Instruction.store(
            operand1Reg: target,
            operand2Reg: operand2Reg,
            addressOffset: Random().nextInt(100)); //TODO: Same todo as above
        break;
    }

    _instructions.add(instruction);
    notifyListeners();
  }
}
