import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Screens/Home.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
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
            Image(
              image: AssetImage("assets/kku-logo.jpeg"),
              width: 200,
              height: 200,
            ),
            SizedBox(height: 50),
            Icon(
              FontAwesomeIcons.route,
              color: kwhite,
              size: 70,
            ),
            SizedBox(height: 50),
            BoldText("KKU", 35.0, kdarkBlue),
            BoldText("Graduation Project", 35.0, kdarkBlue),
            TypewriterAnimatedTextKit(
              text: ["Travel & Food"],
              textStyle: TextStyle(
                  fontSize: 30.0, color: kwhite, fontFamily: "nunito"),
              speed: Duration(milliseconds: 150),
            )
          ],
        ),
      ),
    );
  }
}
