import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaper_app/screens/full_screen_ui.dart';
import 'package:wallpaper_app/screens/home_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
          title: 'Wallpaper App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.cyan,
          ),
          initialRoute: HomeUI.routeName,
          routes: {
            HomeUI.routeName: (context) => HomeUI(),
            FullScreenUI.routeName: (context) => const FullScreenUI(),
          });
    });
  }
}
