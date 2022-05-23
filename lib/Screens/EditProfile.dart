import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => new _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: Colors.transparent,
          title: BoldText("Edit Profile", 35, dayMainColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.check,
                color: dayMainColor,
              ),
              onPressed: () {
                //TODO: SAVE EDITED PROFILE !!!

                FirebaseFirestore.instance
                    .collection("Cities")
                    .doc("Gjp6AG8GF5DY0eL99Uc5")
                    .collection("Places")
                    .doc("6C2cj72RCmalvwSjtd4b")
                    .set({
                  "Hours": {
                    "Friday": "09:00 - 17:00",
                    "Monday": "09:00 - 17:00",
                    "Saturday": "CLOSED",
                    "Sunday": "CLOSED",
                    "Thursday": "09:00 - 17:00",
                    "Tuesday": "09:00 - 17:00",
                    "Wednesday": "09:00 - 17:00",
                  },
                  "imageUrl":
                      "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/Adana.jpg?alt=media&token=480896ff-d4d3-4eeb-91e1-894d8488d8cd",
                  "description": "description",
                  "id": "6C2cj72RCmalvwSjtd4b",
                  "location": "Gjp6AG8GF5DY0eL99Uc5",
                  "name": "Köfteci Yusuf",
                  "rate": "5",
                  "telephone": "555 55 55",
                  "type": "restaurant",
                  "whoSee": {},
                });
              },
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        //TODO: EDIT PROFILE !!!
        child: Text(
          "Coming soon...",
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
