import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomasulo_viz/components/atoms/app_colours.dart';
import 'package:tomasulo_viz/screens/landing_screen/landing_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 720),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Tomasulo Viz',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: AppColours.egyptianBlue),
          home: child,
          builder: (context, widget) {
            return MediaQuery(
              ///Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
      child: const LandingScreen(),
    );
  }
}
