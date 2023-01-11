import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/components/atoms/dimensions.dart';
import 'package:tomasulo_viz/screens/visualizer/visualizer_drawing_constants.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/instructions_queue/instructions_queue.dart';

class VisualizerScreen extends ConsumerStatefulWidget {
  const VisualizerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VisualizerScreenState();
}

class _VisualizerScreenState extends ConsumerState<VisualizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.egyptianBlue,
      body: Stack(
        alignment: Alignment.center,
        children: [
          ...drawAllConnectors(),

          ///Instruction Queue
          MyPositionedSized(
            top: 39.sp,
            left: 41.sp,
            size: Size(368.sp, 224.sp),
            colour: Colors.transparent,
            child: InstructionsQueue(),
          ),

          ///LoadBuffer
          MyPositionedSized(
            size: VizDConstants.memoryBufferSize,
            left: VizDConstants.loadLeft,
            bottom: -VizDConstants.memoryBufferBottom + 1.sh,
          ),

          ///Store Buffer
          MyPositionedSized(
            size: VizDConstants.memoryBufferSize,
            left: VizDConstants.storeLeft,
            bottom: -VizDConstants.memoryBufferBottom + 1.sh,
          ),

          ///Memory
          MyPositionedSized(
            size: VizDConstants.memorySize,
            left: VizDConstants.memoryLeft,
            bottom: -VizDConstants.memoryBotom + 1.sh,
          ),

          ///FP Adders (shifted to right by 24 than design)
          MyPositionedSized(
            size: VizDConstants.FUSize,
            right: -VizDConstants.FPAdderRight + 1.sw,
            bottom: -VizDConstants.FUBottom + 1.sh,
          ),

          ///FP Multipliers
          MyPositionedSized(
            size: VizDConstants.FUSize,
            right: -VizDConstants.FPMultRight + 1.sw,
            bottom: -VizDConstants.FUBottom + 1.sh,
          ),

          ///RS Adders
          MyPositionedSized(
            size: VizDConstants.RSSize,
            right: -VizDConstants.RSAddRight + 1.sw,
            bottom: -VizDConstants.RSBottom + 1.sh,
          ),

          ///RS Multipliers
          MyPositionedSized(
            size: VizDConstants.RSSize,
            right: -VizDConstants.RSMultRight + 1.sw,
            bottom: -VizDConstants.RSBottom + 1.sh,
          ),

          ///AU
          MyPositionedSized(
            size: VizDConstants.ALUSize,
            bottom: -VizDConstants.ALUBottom + 1.sh,
            left: VizDConstants.ALUleft,
          ),

          ///RegFile
          MyPositionedSized(
            size: VizDConstants.regFileSize,
            bottom: -VizDConstants.regFileBottom + 1.sh,
            right: -VizDConstants.regFileRight + 1.sw,
          ),

          // ///Page middle
          // DrawLine(
          //   startPoint: Offset(0, 1.sh / 2),
          //   endPoint: Offset(1.sw, 1.sh / 2),
          // ),
          // DrawLine(
          //     startPoint: Offset(1.sw / 2, 0),
          //     endPoint: Offset(1.sw / 2, 1.sh)),
        ],
      ),
    );
  }

  List<Widget> drawAllConnectors() {
    return [
      //Line Instruction Queue - AU
      DrawLine(
        startPoint: Offset(226.sp, 279.sp),
        endPoint: Offset(
            226.sp, VizDConstants.ALUBottom - VizDConstants.ALUSize.height / 2),
        stroke: 3.sp,
      ),

      ///Connector AU - AULeft
      DrawLine(
          startPoint: Offset(VizDConstants.ALUleft,
              VizDConstants.ALUBottom - VizDConstants.ALUSize.height / 2),
          endPoint: Offset(VizDConstants.leftBus,
              VizDConstants.ALUBottom - VizDConstants.ALUSize.height / 2)),

      ///Connector AULeft - LeftBottom
      DrawLine(
          startPoint: Offset(VizDConstants.leftBus,
              VizDConstants.ALUBottom - VizDConstants.ALUSize.height / 2),
          endPoint: Offset(VizDConstants.leftBus, VizDConstants.bottomBus)),

      ///Connector LeftBottom - RightBottom
      DrawLine(
          startPoint: Offset(VizDConstants.leftBus, VizDConstants.bottomBus),
          endPoint: Offset(VizDConstants.rightBus, VizDConstants.bottomBus)),

      ///Connector RightBottom - RegFileRight
      DrawLine(
          startPoint: Offset(VizDConstants.rightBus, VizDConstants.bottomBus),
          endPoint: Offset(
              VizDConstants.rightBus,
              VizDConstants.regFileBottom -
                  VizDConstants.regFileSize.height / 2)),

      ///Connector RegFileRight - RegFile
      DrawLine(
          startPoint: Offset(
              VizDConstants.rightBus,
              VizDConstants.regFileBottom -
                  VizDConstants.regFileSize.height / 2),
          endPoint: Offset(
              VizDConstants.regFileRight,
              VizDConstants.regFileBottom -
                  VizDConstants.regFileSize.height / 2)),

      ///Connector AU - LoadBuffer
      DrawLine(
        startPoint: Offset(
            VizDConstants.loadLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.ALUBottom - VizDConstants.ALUSize.height / 2),
        endPoint: Offset(
            VizDConstants.loadLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.memoryBufferBottom -
                VizDConstants.memoryBufferSize.height / 2),
        stroke: 3.sp,
      ),

      ///Connector AU - StoreBuffer
      DrawLine(
        startPoint: Offset(
            VizDConstants.storeLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.ALUBottom - VizDConstants.ALUSize.height / 2),
        endPoint: Offset(
            VizDConstants.storeLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.memoryBufferBottom -
                VizDConstants.memoryBufferSize.height / 2),
        stroke: 3.sp,
      ),

      ///Connector LoadBuffer - Memory
      DrawLine(
        startPoint: Offset(
            VizDConstants.loadLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.memoryBufferBottom -
                VizDConstants.memoryBufferSize.height / 2),
        endPoint: Offset(
            VizDConstants.loadLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.memoryBotom - VizDConstants.memorySize.height / 2),
        stroke: 1.sp,
      ),

      ///Connector StoreBuffer - Memory
      DrawLine(
        startPoint: Offset(
            VizDConstants.storeLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.memoryBufferBottom -
                VizDConstants.memoryBufferSize.height / 2),
        endPoint: Offset(
            VizDConstants.storeLeft + VizDConstants.memoryBufferSize.width / 2,
            VizDConstants.memoryBotom - VizDConstants.memorySize.height / 2),
        stroke: 1.sp,
      ),

      ///Connector RSAdd - FPAdders
      DrawLine(
        startPoint: Offset(
            VizDConstants.RSAddRight - VizDConstants.RSSize.width / 2,
            VizDConstants.RSBottom - VizDConstants.RSSize.height / 2),
        endPoint: Offset(
            VizDConstants.RSAddRight - VizDConstants.RSSize.width / 2,
            VizDConstants.FUBottom - VizDConstants.FUSize.height / 2),
        stroke: 1.sp,
      ),

      ///Connector RSMult - FPMult
      DrawLine(
        startPoint: Offset(
            VizDConstants.RSMultRight - VizDConstants.RSSize.width / 2,
            VizDConstants.RSBottom - VizDConstants.RSSize.height / 2),
        endPoint: Offset(
            VizDConstants.RSMultRight - VizDConstants.RSSize.width / 2,
            VizDConstants.FUBottom - VizDConstants.FUSize.height / 2),
        stroke: 1.sp,
      ),

      ///Connector FPAdd - RegFile
      DrawLine(
        startPoint: Offset(
            VizDConstants.RSAddRight - VizDConstants.RSSize.width / 2,
            VizDConstants.RSBottom - VizDConstants.RSSize.height / 2),
        endPoint: Offset(
            VizDConstants.RSAddRight - VizDConstants.RSSize.width / 2,
            VizDConstants.regFileBottom - VizDConstants.regFileSize.height / 2),
        stroke: 5.sp,
      ),

      ///Connector FPMult - RegFile
      DrawLine(
        startPoint: Offset(
            VizDConstants.RSMultRight - VizDConstants.RSSize.width / 2,
            VizDConstants.RSBottom - VizDConstants.RSSize.height / 2),
        endPoint: Offset(
            VizDConstants.RSMultRight - VizDConstants.RSSize.width / 2,
            VizDConstants.regFileBottom - VizDConstants.regFileSize.height / 2),
        stroke: 5.sp,
      ),

      ///Connector FPAdd/RegFile - Right
      DrawLine(
        startPoint: Offset(
            VizDConstants.RSAddRight - VizDConstants.RSSize.width / 2,
            ((VizDConstants.RSBottom - VizDConstants.RSSize.height) +
                    VizDConstants.regFileBottom) /
                2),
        endPoint: Offset(
            VizDConstants.rightBus,
            ((VizDConstants.RSBottom - VizDConstants.RSSize.height) +
                    VizDConstants.regFileBottom) /
                2),
        stroke: 5.sp,
      ),

      ///Connector Memory - Bottom
      DrawLine(
          startPoint: Offset(
              VizDConstants.memoryLeft + VizDConstants.memorySize.width / 2,
              VizDConstants.memoryBotom - VizDConstants.memorySize.height / 2),
          endPoint: Offset(
              VizDConstants.memoryLeft + VizDConstants.memorySize.width / 2,
              VizDConstants.bottomBus)),
    ];
  }
}

class MyPositionedSized extends StatelessWidget {
  const MyPositionedSized(
      {Key? key,
      this.size,
      this.top,
      this.right,
      this.bottom,
      this.left,
      this.child,
      this.colour = AppColours.lightBlue})
      : super(key: key);

  final Size? size;
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final Widget? child;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Container(
        width: size?.width,
        height: size?.height,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: Dimensions.defaultButtonRadius,
        ),
        child: child,
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter({required this.startPoint, required this.endPoint, this.stroke});

  final Offset startPoint;
  final Offset endPoint;
  final double? stroke;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColours.darkBlue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke ?? 5.sp;
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class DrawLine extends StatelessWidget {
  const DrawLine(
      {super.key,
      required this.startPoint,
      required this.endPoint,
      this.stroke});

  final Offset startPoint;
  final Offset endPoint;
  final double? stroke;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1.sw, 1.sh),
      painter: LinePainter(
          startPoint: startPoint, endPoint: endPoint, stroke: stroke),
    );
  }
}
