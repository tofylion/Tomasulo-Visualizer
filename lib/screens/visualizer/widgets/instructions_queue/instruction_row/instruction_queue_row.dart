import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instruction_row/instruction_row_element.dart';

class InstructionQueueRow extends ConsumerStatefulWidget {
  const InstructionQueueRow(
      {super.key, required this.instruction, required this.status});

  final Instruction instruction;
  final InstructionStatus status;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstructionQueueRowState();
}

class _InstructionQueueRowState extends ConsumerState<InstructionQueueRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InstructionRowElement(
          status: widget.status,
          content: widget.instruction.type.name.toUpperCase(),
          isInstructionType: true,
        ),
        if (!hideTarget)
          InstructionRowElement(
              status: widget.status, content: widget.instruction.target ?? ''),
        if (!hideOperand1)
          InstructionRowElement(
              status: widget.status,
              content: widget.instruction.operand1Reg ?? ''),
        if (hideOperand1 || hideTarget)
          InstructionRowElement(
              status: widget.status,
              content: widget.instruction.addressOffset.toString()),
        InstructionRowElement(
            status: widget.status,
            content: widget.instruction.operand2Reg ?? ''),
        InstructionRowElement(
            status: widget.status, content: '1', expanded: false),
        InstructionRowElement(status: widget.status, content: '2..4'),
        InstructionRowElement(
            status: widget.status, content: '1', expanded: false),
      ],
    );
  }

  bool get hideOperand1 => widget.instruction.type == InstructionType.load;
  bool get hideTarget => widget.instruction.type == InstructionType.store;
}
