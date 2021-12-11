import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: BoldText("My Profile", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: kgreyDark,
                    backgroundImage: AssetImage(myInfo["profileImage"]),
                    radius: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      BoldText(myInfo["name"] + " " + myInfo["surname"], 20.0,
                          kblack),
                      NormalText(myInfo["e-mail"], kgreyDark, 16),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 2,
              color: kgreyFill,
            ),
            ProfileItem(Icons.person, "My Informations"),
            ProfileItem(Icons.info, "About Us "),
            ProfileItem(Icons.exit_to_app, "Sign Out"),
          ],
        ),
      ),
    );
  }

  Widget ProfileItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 9),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: kdarkBlue,
            size: 40,
          ),
          SizedBox(
            width: 8,
          ),
          NormalText(text, kblack, 20.0)
        ],
      ),
    );
  }
}
