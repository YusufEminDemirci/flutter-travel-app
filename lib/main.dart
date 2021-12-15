import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/Home.dart';
import 'package:lets_head_out/Screens/Splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: status == true ? Home() : SplashScreen(),
    title: 'Travel App design',
  ));
}
