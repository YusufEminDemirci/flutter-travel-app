import 'package:flutter/material.dart';
import 'package:travel_food/Screens/Slider/Slider_Prefab.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Slider_Prefab(),
    );
  }
}
