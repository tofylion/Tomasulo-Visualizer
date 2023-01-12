import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/clock.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';
import 'package:tomasulo_viz/models/providers/instruction_queue_provider.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instruction_row/instruction_queue_row_element.dart';

class InstructionsQueueViewModel extends ChangeNotifier {
  InstructionsQueueViewModel(
      {required InstructionQueue instructions, required Clock clock}) {
    _instructions = instructions;
    _clock = clock;
  }

  late final InstructionQueue _instructions;
  late final Clock _clock;
  // InstructionQueue get instructions => _instructions;

  int get instructionsLength => _instructions.instructions.length;

  Instruction? get currentInstruction => _instructions.currentInstruction;

  int get currentInstructionIndex => _instructions.index;

  Instruction? getInstructionByIndex(int index) =>
      _instructions.instructions[index];

  InstructionStatus getInstructionStatus(int index) {
    final curIndex = _instructions.index;
    if (curIndex > index) {
      return InstructionStatus.issued;
    } else if (curIndex == index) {
      return InstructionStatus.selected;
    } else {
      return InstructionStatus.pending;
    }
  }

  int get clockCycle => _clock.cycles;

  static final provider =
      ChangeNotifierProvider<InstructionsQueueViewModel>((ref) {
    final instructions = ref.watch(instructionQueueProvider);
    final clock = ref.watch(clockProvider);
    return InstructionsQueueViewModel(instructions: instructions, clock: clock);
  });
}
