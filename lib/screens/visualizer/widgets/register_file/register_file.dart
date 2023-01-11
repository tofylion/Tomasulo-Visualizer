import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/models/providers/clock_provider.dart';
import 'package:tomasulo_viz/models/providers/registers_providers.dart';
import 'package:tomasulo_viz/screens/visualizer/widgets/register_file/register_column/register_column.dart';

class RegisterFileWidget extends ConsumerStatefulWidget {
  const RegisterFileWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterFileWidgetState();
}

class _RegisterFileWidgetState extends ConsumerState<RegisterFileWidget> {
  late final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final registerFile = ref.read(registerFileProvider);
    ref.watch(clockProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Scrollbar(
          controller: _controller,
          child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final registerList = registerFile.registers.keys.toList();
                registerList.sort();

                return RegisterColumn(
                  registerId: registerList[index],
                );
              },
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              separatorBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 7.sp, horizontal: 16.sp),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 0.sp,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColours.black50,
                                  width: 1.sp,
                                  strokeAlign: StrokeAlign.center)),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: registerFile.registers.length)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
