import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/Splash.dart';
import 'Screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      title: 'Travel App design',
    ),
  );
}
