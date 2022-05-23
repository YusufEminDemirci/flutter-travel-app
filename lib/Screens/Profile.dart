import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:travel_food/Screens/EditProfile.dart';
import 'package:travel_food/Screens/Notifications.dart';
import 'package:travel_food/Screens/AboutUs.dart';
import 'package:travel_food/Screens/SignIn.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: BoldText("My Profile", 35, kwhite),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.solidBell,
                color: kwhite,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new Notifications()),
                );
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: new BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                            color: dayMainColor.withOpacity(0.6),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.75,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 72,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: (userImageUrl != null)
                                ? NetworkImage(userImageUrl)
                                : AssetImage("assets/orangeProfile.png"),
                            radius: 70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 200.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              (userName != null && userSurname != null)
                                  ? BoldText(
                                      userName + " " + userSurname,
                                      25.0,
                                      kwhite,
                                    )
                                  : BoldText(
                                      "Name Surname",
                                      30,
                                      kwhite,
                                    ),
                              Container(
                                height: 2,
                                width: ((userName + " " + userSurname)
                                        .length
                                        .toDouble()) *
                                    20,
                                color: kwhite,
                              ),
                              SizedBox(height: 25.0),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //         child: Container(
                //           height: 130,
                //           width: 130,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: kwhite,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.2),
                //                   blurRadius: 10,
                //                   spreadRadius: 5,
                //                 ),
                //               ]),
                //           child: profileItem(
                //               FontAwesomeIcons.edit, "Edit Profile"),
                //         ),
                //         onTap: () async {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => new EditProfile()));
                //         }),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kwhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ]),
                          child: profileItem(FontAwesomeIcons.info, "About Us"),
                        ),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new AboutUs()));
                        }),
                    GestureDetector(
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kwhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ]),
                          child: profileItem(
                              FontAwesomeIcons.signOutAlt, "Sign Out"),
                        ),
                        onTap: () {
                          Dialogs.materialDialog(
                            msg: 'Are you sure ?',
                            title: "Sign Out",
                            color: Colors.white,
                            context: context,
                            actions: [
                              IconsOutlineButton(
                                text: 'Cancel',
                                textStyle: TextStyle(color: Colors.grey),
                                iconData: Icons.cancel_outlined,
                                iconColor: Colors.grey,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              IconsButton(
                                color: Colors.red,
                                text: 'Sign Out',
                                textStyle: TextStyle(color: Colors.white),
                                iconData: FontAwesomeIcons.signOutAlt,
                                iconColor: Colors.white,
                                onPressed: () async {
                                  if (_auth.currentUser != null) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    prefs.setString('userEmail', "");
                                    prefs.setString('userName', "");
                                    prefs.setString('userSurname', "");
                                    prefs.setString('userImageUrl', "");
                                    prefs.setString('userId', "");
                                    prefs.setString('userPassword', "");

                                    prefs.setBool('isLoggedIn', false);

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new SignInPage()),
                                        ModalRoute.withName("/Home"));
                                  }
                                },
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget profileItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            color: kdarkBlue,
            size: 35,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: kblack,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
