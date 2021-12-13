import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/seenLocationsList.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Screens/MyInformation.dart';

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
        backgroundColor: mainColor,
        title: BoldText("My Profile", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: kgreyDark,
                  backgroundImage: AssetImage(myInfo["profileImage"]),
                  radius: 40,
                ),
                BoldText(
                    myInfo["name"] + " " + myInfo["surname"], 16.0, kblack),
                NormalText(myInfo["e-mail"], kgreyDark, 14),
              ],
            ),
            Container(
              height: 2,
              color: kgreyFill,
            ),
            profileItem(Icons.person, "My Information"),
            profileItem(Icons.list, "Seen Locations"),
            profileItem(Icons.info, "About Us "),
            profileItem(Icons.exit_to_app, "Sign Out"),
          ],
        ),
      ),
    );
  }

  Widget profileItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 9),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: kgreyDark,
              backgroundImage: AssetImage(myInfo["profileImage"]),
              radius: 20,
              child: Icon(
                icon,
                color: kblack,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            NormalText(text, kblack, 20.0)
          ],
        ),
        onTap: () {
          if (text == "My Information") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new MyInformation()));
          } else if (text == "Seen Locations") {
            // About Us;
          } else if (text == "About Us") {
            // About Us;
          } else if (text == "Sign Out") {
            // Sign Out;
          }
        },
      ),
    );
  }
}

getSeenLocations(String cityId) {
  List<LocationsImage> getSeenLocations = [];
  for (int index = 0; index < seenLocations.length; index++) {
    getSeenLocations.add(LocationsImage(
      seenLocations[index].id,
      seenLocations[index].imageUrl,
      seenLocations[index].name,
      seenLocations[index].location,
      seenLocations[index].description,
      seenLocations[index].comment,
      seenLocations[index].rate,
      seenLocations[index].type,
      seenLocations[index].cityId,
    ));
  }
  return getSeenLocations;
}
