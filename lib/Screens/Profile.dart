import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Screens/Notifications.dart';
import 'package:lets_head_out/Screens/SeenLocations.dart';
import 'package:lets_head_out/Screens/AboutUs.dart';
import 'package:lets_head_out/Screens/SignIn.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();
    // getUserInfo();
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Notifications()));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/hotel.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(
                      0.0,
                      73.0,
                    ),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 75.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      child: Container(
                        height: MediaQuery.of(context).size.height - 311,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: kwhite,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BoldText(
                                  myInformation[0].name +
                                      " " +
                                      myInformation[0].surname,
                                  25.0,
                                  kblack),
                              Container(
                                height: 2,
                                width: ((myInformation[0].name +
                                            " " +
                                            myInformation[0].surname)
                                        .length
                                        .toDouble()) *
                                    20,
                                color: mainColor,
                              ),
                              SizedBox(height: 25.0),
                              profileItem(
                                  FontAwesomeIcons.route, "Seen Locations"),
                              profileItem(FontAwesomeIcons.info, "About Us"),
                              profileItem(
                                  FontAwesomeIcons.signOutAlt, "Sign Out"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 57,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(myInformation[0].imageUrl),
                          backgroundColor: Colors.white,
                          radius: 55,
                        ),
                      ),
                      onTap: () {
                        //TODO: CHANGE PROFILE PICTURE !!!
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              prefs.setBool('isLoggedIn', false) ?? false;
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

// getUserInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   _name = prefs.getString('UserName') ?? false;
//   _surname = prefs.getString('UserSurname') ?? false;
// }
