import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/citiesList.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Models/city.dart';
import 'package:lets_head_out/Models/user.dart';
import 'package:lets_head_out/Screens/Home.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getCitiesInfo();
    getUserInfo();
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
        backgroundColor: Colors.amber,
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
              BoldText("Graduation Project 1", 35.0, kdarkBlue),
              TypewriterAnimatedTextKit(
                text: ["Travel & Food"],
                textStyle: TextStyle(
                    fontSize: 30.0, color: kwhite, fontFamily: "nunito"),
                speed: Duration(milliseconds: 150),
              )
            ],
          ),
        ));
  }
}

getCitiesInfo() {
  final firestoreInstance = FirebaseFirestore.instance;

  firestoreInstance.collection("Cities").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String _id = result.data()["id"];
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      cities.add(City(id: _id, imageUrl: _imageUrl, name: _name));
    });
  });
}

getUserInfo() {
  final firestoreInstance = FirebaseFirestore.instance;

  firestoreInstance.collection("Users").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      String _surname = result.data()["surname"];
      myInformation.add(User(_imageUrl, _name, _surname));
    });
  });
}
