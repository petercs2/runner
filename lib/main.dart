import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:point_run/db_point/db_point.dart';
import 'package:point_run/pages/point_error/point_error_binding.dart';
import 'package:point_run/pages/point_error/point_error_view.dart';
import 'package:point_run/pages/point_first/point_first_binding.dart';
import 'package:point_run/pages/point_first/point_first_view.dart';
import 'package:point_run/pages/point_second/point_second_binding.dart';
import 'package:point_run/pages/point_second/point_second_view.dart';
import 'package:point_run/pages/point_third/point_third_binding.dart';
import 'package:point_run/pages/point_third/point_third_view.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.white;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBPoint().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Points,
      initialRoute: '/pointFirst',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Points = [
  GetPage(name: '/pointFirst', page: () => const PointFirstPage(), binding: PointFirstBinding()),
  GetPage(name: '/pointSecond', page: () => const PointSecondPage(), binding: PointSecondBinding()),
  GetPage(name: '/pointThird', page: () => PointThirdPage(), binding: PointThirdBinding()),
  GetPage(name: '/pointError', page: () => const PointErrorView(), binding: PointErrorBinding()),
];