import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instruction_row/instruction_queue_row.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instruction_row/instruction_row_element.dart';

class InstructionsQueue extends ConsumerStatefulWidget {
  const InstructionsQueue({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstructionsQueueState();
}

class _InstructionsQueueState extends ConsumerState<InstructionsQueue> {
  late final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    const InstructionStatus status = InstructionStatus.pending;
    final testInstruction =
        Instruction.add(target: 'R1', operand1Reg: 'R1', operand2Reg: 'R1');
    return ListView(
      controller: _controller,
      children: [
        InstructionQueueRow(instruction: testInstruction, status: status),
      ],
    );
  }
}
