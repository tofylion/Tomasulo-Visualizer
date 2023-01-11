import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instruction_row/instruction_queue_row.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instruction_row/instruction_queue_row_element.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instructions_queue_view_model.dart';

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
    final vm = ref.watch(InstructionsQueueViewModel.provider);
    return Scrollbar(
      controller: _controller,
      child: ListView.builder(
        controller: _controller,
        itemCount: vm.instructionsLength,
        itemBuilder: (context, index) {
          final status = vm.getInstructionStatus(index);
          final instruction = vm.getInstructionByIndex(index);

          return Column(
            children: [
              if (index != 0) SizedBox(height: 11.sp),
              InstructionQueueRow(
                instruction: instruction!,
                status: status,
                clockCycle: vm.clockCycle,
              ),
            ],
          );
        },
      ),
    );
  }
}
