import 'dart:async';
import 'package:student_app/util/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:student_app/mvc/view/student_list_page.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await initApp();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      GetMaterialApp(
        home: const StudentListPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        builder: EasyLoading.init(),
      ),
    );

  } catch (ex, stack) {
    print(ex);
  }
}


Future initApp() async {

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60.0
    ..radius = 100.0
    ..progressColor = Keys.secondaryColor
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Keys.secondaryColor
    ..textColor = Colors.white
    ..maskColor = Colors.black45
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    double opacity = controller.value; //controller?.value ?? 0;
    return Opacity(
      opacity: opacity,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
