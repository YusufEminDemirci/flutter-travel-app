import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Screens/Notifications.dart';
import 'package:lets_head_out/Screens/SeenLocations.dart';
import 'package:lets_head_out/Screens/AboutUs.dart';
import 'package:lets_head_out/Screens/SignIn.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String userName;
String userSurname;
String userImageUrl;

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
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SlidingUpPanel(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              minHeight: MediaQuery.of(context).size.height * 0.1,
              panel: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: kwhite,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Container(
                                height: 3,
                                width: 80,
                                color: Colors.grey.shade300),
                            SizedBox(
                              height: 15,
                            ),
                            BoldText(
                                userName + " " + userSurname, 25.0, kblack),
                            Container(
                              height: 2,
                              width: ((userName + " " + userSurname)
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
                  Align(
                    alignment: Alignment(0, -2.0),
                    child: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 67,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userImageUrl),
                          backgroundColor: Colors.white,
                          radius: 65,
                        ),
                      ),
                      onTap: () {
                        //TODO: CHANGE PROFILE PICTURE !!!
                        showNotificationSnackBar(
                            context, "Changed Profile Picture");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
              SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs.setString('userEmail', "");
              prefs.setString('userName', "");
              prefs.setString('userSurname', "");
              prefs.setString('userImageUrl', "");
              prefs.setString('userId', "");
              prefs.setString('userPassword', "");

              prefs.setBool('isLoggedIn', false);

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

  userName = prefs.getString('userName');
  userSurname = prefs.getString('userSurname');
  userImageUrl = prefs.getString('userImageUrl');
}

showNotificationSnackBar(BuildContext context, String text) async {
  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
