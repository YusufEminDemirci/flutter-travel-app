import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Screens/Home/Home.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new Home()),
          ModalRoute.withName("/Home"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dayMainColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.route,
                color: kwhite,
                size: 70,
              ),
              SizedBox(height: 50),
              BoldText("Graduation Project 1-2", 35.0, dayTextColor),
              TypewriterAnimatedTextKit(
                text: ["Travel & Food"],
                textStyle: TextStyle(
                  fontSize: 30.0,
                  color: kwhite,
                  fontFamily: "Brandon",
                ),
                speed: Duration(milliseconds: 150),
              )
            ],
          ),
        ));
  }
}
