import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/components/molecules/tappable.dart';
import 'package:tomasulo_viz/components/widgets/inputs/primary_drop_down.dart';
import 'package:tomasulo_viz/components/widgets/inputs/primary_number_input_field.dart';
import 'package:tomasulo_viz/constants/app_timing.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/models/providers/registers_providers.dart';

class InstructionScreenRow extends ConsumerStatefulWidget {
  const InstructionScreenRow(
      {Key? key, required this.instruction, required this.index, this.remove})
      : super(key: key);

  final Instruction instruction;
  final int index;
  final Function(int index)? remove;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InstrictionRowState();
}

class _InstrictionRowState extends ConsumerState<InstructionScreenRow>
    with SingleTickerProviderStateMixin {
  late final List<String> allRegisters;
  late final AnimationController _controller;
  late int previousIndex = widget.index;
  @override
  void initState() {
    allRegisters = ref
        .read(registerFileProvider)
        .registers
        .entries
        .map((entry) => entry.key)
        .toList();
    allRegisters.sort();
    _controller = AnimationController(
        value: 0, vsync: this, duration: AppTiming.transitionsDuration)
      ..forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index != previousIndex) {
      previousIndex = widget.index;
      _controller
        ..reset()
        ..forward();
    }
    return Row(
      children: [
        ReorderableDragStartListener(
          index: widget.index,
          child: TextButton(
            onPressed: () => DoNothingAction(),
            child: Container(
              height: 50.sp,
              width: 50.sp,
              decoration: BoxDecoration(
                color: AppColours.lightBlue,
                borderRadius: Dimensions.defaultButtonRadius,
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _controller,
                    child: child,
                  );
                },
                child: Center(
                  child: Text(
                    (widget.index + 1).toString(),
                    style: AppTextStyles.dp36EgyptianBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 13.sp),
        instructionTypeText(),
        if (!hideTarget) ...[
          SizedBox(width: 10.sp),
          PrimaryDropDown(
              value: widget.instruction.target,
              items: allRegisters,
              onChanged: updateTarget),
        ],
        if (!hideOperand1) ...[
          SizedBox(width: 10.sp),
          PrimaryDropDown(
              value: widget.instruction.operand1Reg,
              items: allRegisters,
              onChanged: updateOperand1),
        ],
        if (hideOperand1 || hideTarget) ...[
          SizedBox(width: 10.sp),
          PrimaryNumberInputField(
            initialValue: widget.instruction.addressOffset.toString(),
            width: 100.sp,
            height: 50.sp,
            style: AppTextStyles.dp32EgyptianBlue,
            onChanged: updateAddress,
          )
        ],
        SizedBox(width: 10.sp),
        PrimaryDropDown(
            value: widget.instruction.operand2Reg,
            items: allRegisters,
            onChanged: updateOperand2),
        SizedBox(width: 18.sp),
        Tappable(
            child: TextButton(
          onPressed: () => widget.remove?.call(widget.index),
          child: Container(
            height: 50.sp,
            width: 54.sp,
            decoration: BoxDecoration(
                color: AppColours.yellowBrickRoad,
                borderRadius: Dimensions.defaultButtonRadius),
            child: Center(
              child: Text('X', style: AppTextStyles.dp36Black),
            ),
          ),
        ))
      ],
    );
  }

  Widget instructionTypeText() {
    return Container(
      width: 150.sp,
      height: 50.sp,
      decoration: BoxDecoration(
        color: AppColours.lightBlue,
        borderRadius: Dimensions.defaultButtonRadius,
      ),
      child: Center(
        child: Text(
          widget.instruction.type.name.toUpperCase(),
          style: AppTextStyles.dp32EgyptianBlue,
        ),
      ),
    );
  }

  void updateTarget(String? value) {
    if (value != null) {
      setState(() {
        widget.instruction.target = value;
      });
    }
  }

  void updateOperand1(String? value) {
    if (value != null) {
      setState(() {
        widget.instruction.operand1Reg = value;
      });
    }
  }

  void updateOperand2(String? value) {
    if (value != null) {
      setState(() {
        widget.instruction.operand2Reg = value;
      });
    }
  }

  void updateAddress(String value) {
    final parsedValue = int.tryParse(value);
    if (parsedValue != null) {
      setState(() {
        widget.instruction.addressOffset = parsedValue;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get hideOperand1 => widget.instruction.type == InstructionType.load;
  bool get hideTarget => widget.instruction.type == InstructionType.store;
}
