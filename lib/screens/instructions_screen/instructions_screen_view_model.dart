import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/constants/app_config.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/models/operation_station.dart';
import 'package:tomasulo_viz/models/providers/clock_functions.dart';
import 'package:tomasulo_viz/models/providers/memory_provider.dart';
import 'package:tomasulo_viz/models/providers/registers_providers.dart';
import 'package:tomasulo_viz/screens/visualizer/main/visualizer_screen.dart';

class InstructionsScreenViewModel extends ChangeNotifier {
  InstructionsScreenViewModel(
      {required this.registers, required this.config, required this.memory});
  final List<String> registers;
  final AppConfig config;
  final MemOperationStation memory;

  List<Instruction> get instructions => config.instructions;

  static final provider =
      ChangeNotifierProvider<InstructionsScreenViewModel>((ref) {
    final registerFile = ref.read(registerFileProvider);
    final registerList =
        registerFile.registers.entries.map((entry) => entry.key).toList();
    registerList.sort();
    final config = ref.read(AppConfig.provider);
    final memory = ref.read(memoryProvider);
    return InstructionsScreenViewModel(
        registers: registerList, config: config, memory: memory);
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
    instructions.removeAt(index);
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
            addressOffset: Random().nextInt(memory.memory.length ~/ 2));
        break;
      case InstructionType.store:
        instruction = Instruction.store(
            operand1Reg: target,
            operand2Reg: operand2Reg,
            addressOffset: Random().nextInt(memory.memory.length ~/ 2));
        break;
    }

    instructions.add(instruction);
    notifyListeners();
  }

  void goNext(BuildContext context, WidgetRef ref) {
    if (instructions.isNotEmpty) {
      //Check for everything
      initClockListeners(ref);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VisualizerScreen(),
          ));
    } else {
      const snackBar = SnackBar(content: Text("Instructions can't be empty!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
