import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
    getUserInfo();
    super.initState();
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
                image: AssetImage("assets/hotel.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SlidingUpPanel(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              minHeight: 50,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Align(
              alignment: Alignment.topCenter,
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
                  // ImagePicker()
                  //     .getImage(source: ImageSource.gallery)
                  //     .then((image) {
                  //   setState(() {
                  //     userImageUrl = image.toString();
                  //   });
                  // });
                },
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
