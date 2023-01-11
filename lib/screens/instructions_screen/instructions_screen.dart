import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprung/sprung.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/components/widgets/buttons/cta_button.dart';
import 'package:tomasulo_viz/components/widgets/buttons/secondary_button.dart';
import 'package:tomasulo_viz/constants/app_assets.dart';
import 'package:tomasulo_viz/constants/app_timing.dart';
import 'package:tomasulo_viz/models/instruction.dart';
import 'package:tomasulo_viz/screens/instructions_screen/instructions_screen_view_model.dart';
import 'package:tomasulo_viz/screens/instructions_screen/widgets/instruction_row.dart';

class InstructionsScreen extends ConsumerStatefulWidget {
  const InstructionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstructionsScreenState();
}

class _InstructionsScreenState extends ConsumerState<InstructionsScreen> {
  late final ScrollController horizontalController;
  late final ScrollController verticalController;

  @override
  void initState() {
    horizontalController = ScrollController();
    verticalController = ScrollController();
    _scrollDown();
    super.initState();
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(InstructionsScreenViewModel.provider);
    return Scaffold(
      backgroundColor: AppColours.egyptianBlue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppAssets.instructionsHeader,
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.fitWidth,
            colorBlendMode: BlendMode.src,
            alignment: Alignment.topRight,
          ),
          Positioned.fill(
            child: Align(
                child: Padding(
              padding: EdgeInsets.only(
                  top: 204.sp, right: 58.sp, bottom: 150.sp, left: 58.sp),
              child: Padding(
                padding: EdgeInsets.only(right: 122.sp),
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                          controller: verticalController,
                          child: ReorderableListView.builder(
                            buildDefaultDragHandles: false,
                            proxyDecorator: proxyDecorator,
                            itemCount: vm.instructions.length,
                            scrollController: verticalController,
                            onReorder: vm.reorderInstructions,
                            itemBuilder: (context, index) {
                              final instruction = vm.instructions[index];
                              return Column(
                                key: ValueKey(instruction),
                                children: [
                                  InstructionRow(
                                    instruction: instruction,
                                    index: index,
                                    remove: vm.removeInstruction,
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                ],
                              );
                            },
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 63.sp),
                      child: instructionAddingButtons(vm),
                    ),
                  ],
                ),
              ),
            )),
          ),
          Positioned(
              bottom: 59.sp,
              right: 48.sp,
              child: CTAButton(
                text: 'Next',
                onPressed: () => DoNothingAction(),
              )),
          Positioned(
              bottom: 59.sp,
              left: 48.sp,
              child: CTAButton(
                text: 'Back',
                onPressed: () => Navigator.pop(context),
              ))
        ],
      ),
    );
  }

  SizedBox instructionAddingButtons(InstructionsScreenViewModel vm) {
    return SizedBox(
      height: 80.sp,
      width: Size.infinite.width,
      child: Scrollbar(
        controller: horizontalController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: ListView.builder(
          controller: horizontalController,
          scrollDirection: Axis.horizontal,
          itemCount: InstructionType.values.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SecondaryButton(
                  text: InstructionType.values[index].name.toUpperCase(),
                  fixedSize: MaterialStateProperty.all<Size?>(
                      Dimensions.minButtonSize),
                  onPressed: () {
                    vm.createInstruction(InstructionType.values[index]);
                    _scrollDown();
                  },
                ),
                SizedBox(
                  width: 12.sp,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      verticalController.animateTo(
        verticalController.position.maxScrollExtent,
        duration: AppTiming.scrollAnimationDuration,
        curve: Sprung.overDamped,
      );
    });
  }
}
