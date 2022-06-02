import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/Home/Home.dart';
// import 'Screens/Welcome.dart';
import 'Utils/consts.dart';

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
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      title: 'Travel App design',
      theme: ThemeData(primaryColor: dayMainColor),
    ),
  );
}
