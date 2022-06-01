import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_food/Screens/Splash.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: transparentColor,
      systemNavigationBarColor: dayMainColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.amber,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            title: 'Travel App design',
            theme: ThemeData(primaryColor: dayMainColor),
          );
        }),
  );
}
