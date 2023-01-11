import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/app_shadows.dart';
import 'package:tomasulo_viz/components/atoms/app_text_styles.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/constants/app_timing.dart';

enum InstructionStatus { pending, selected, issued }

class InstructionRowElement extends ConsumerStatefulWidget {
  const InstructionRowElement(
      {super.key,
      required this.status,
      required this.content,
      this.isInstructionType = false,
      this.expanded = true});

  final InstructionStatus status;
  final String content;
  final bool isInstructionType;
  final bool expanded;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstructionRowElementState();
}

class _InstructionRowElementState extends ConsumerState<InstructionRowElement> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppTiming.transitionsDuration,
      opacity: elementOpacity,
      child: AnimatedContainer(
        duration: AppTiming.transitionsDuration,
        width: elementSize.width,
        height: elementSize.height,
        decoration: decoration,
        child: Center(
          child: Text(
            widget.content,
            style: elementsTextStyle,
          ),
        ),
      ),
    );
  }

  TextStyle get elementsTextStyle {
    late final TextStyle style;
    switch (widget.status) {
      case InstructionStatus.pending:
      case InstructionStatus.issued:
        style = AppTextStyles.dp24LightBlue;
        break;

      case InstructionStatus.selected:
        style = AppTextStyles.dp24Black;
        break;
    }
    if (widget.isInstructionType) {
      return style.copyWith(fontSize: 20.sp);
    } else {
      return style;
    }
  }

  BoxDecoration get decoration {
    late final BoxDecoration decoration;
    switch (widget.status) {
      case InstructionStatus.pending:
      case InstructionStatus.issued:
        decoration = BoxDecoration(
            borderRadius: Dimensions.defaultButtonRadius,
            color: AppColours.darkBlue);
        break;
      case InstructionStatus.selected:
        decoration = BoxDecoration(
            borderRadius: Dimensions.defaultButtonRadius,
            color: AppColours.lightBlue,
            boxShadow: [AppShadows.shadowDark3]);
        break;
    }
    return decoration;
  }

  Size get elementSize {
    late final Size size;
    switch (widget.status) {
      case InstructionStatus.pending:
      case InstructionStatus.issued:
        size = Size(
            widget.expanded
                ? widget.isInstructionType
                    ? 66.sp
                    : 50.sp
                : 30.sp,
            47.sp);
        break;
      case InstructionStatus.selected:
        size = Size(
            widget.expanded
                ? widget.isInstructionType
                    ? 69.16.sp
                    : 53.16.sp
                : 31.89.sp,
            50.sp);
        break;
    }
    return size;
  }

  double get elementOpacity {
    late final double opacity;
    switch (widget.status) {
      case InstructionStatus.pending:
      case InstructionStatus.selected:
        opacity = 1;
        break;
      case InstructionStatus.issued:
        opacity = 0.5;
        break;
    }
    return opacity;
  }
}
