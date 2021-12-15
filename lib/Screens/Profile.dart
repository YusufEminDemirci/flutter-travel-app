import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Screens/SeenLocations.dart';
import 'package:lets_head_out/Screens/AboutUs.dart';
import 'package:lets_head_out/Screens/SignIn.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String _surname;
String _name;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("My Profile", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ibis.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 75.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: kwhite,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BoldText(_auth.currentUser.email, 25.0, kblack),
                              Container(
                                height: 2,
                                width: (_auth.currentUser.email.length
                                        .toDouble()) *
                                    20,
                                color: mainColor,
                              ),
                              SizedBox(height: 25.0),
                              profileItem(
                                  FontAwesomeIcons.route, "Seen Locations"),
                              profileItem(Icons.info, "About Us"),
                              profileItem(Icons.exit_to_app, "Sign Out"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 57,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(myInfo["profileImage"]),
                        backgroundColor: Colors.white,
                        radius: 55,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 9),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: Icon(
                icon,
                color: kdarkBlue,
                size: 30,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            NormalText(text, kblack, 22.0)
          ],
        ),
        onTap: () async {
          if (text == "Seen Locations") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new SeenLocations()));
          } else if (text == "About Us") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new AboutUs()));
          } else if (text == "Sign Out") {
            if (_auth.currentUser != null) {
              await _auth.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var status = prefs.setBool('isLoggedIn', false) ?? false;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => new SignInPage()),
                  ModalRoute.withName("/Home"));
            }
          }
        },
      ),
    );
  }
}

getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _name = prefs.getString('UserName') ?? false;
  _surname = prefs.getString('UserSurname') ?? false;
}
