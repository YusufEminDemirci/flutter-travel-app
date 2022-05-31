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
                    .doc("bwHzr7Tg3E8ceJPE6ccU")
                    .collection("Places")
                    .doc("jyrDJRrRsauF1RRdOwqB")
                    .set({
                  "Hours": {
                    "Friday": "11:00 - 02:00",
                    "Monday": "11:00 - 02:00",
                    "Saturday": "11:00 - 02:00",
                    "Sunday": "11:00 - 02:00",
                    "Thursday": "11:00 - 02:00",
                    "Tuesday": "11:00 - 02:00",
                    "Wednesday": "11:00 - 02:00",
                  },
                  "imageUrl":
                      "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/midyeci-ahmet.jpg?alt=media&token=36859e96-0abb-4ec6-b574-9101a17c73df",
                  "description": "Midyeci",
                  "id": "jyrDJRrRsauF1RRdOwqB",
                  "location": "bwHzr7Tg3E8ceJPE6ccU",
                  "name": "Midyeci Ahmet",
                  "rate": "3.1",
                  "telephone": "02324044556",
                  "type": "place",
                  "whoSee": {},
                  "latitude": "38.4353292",
                  "longitude": "27.145659",
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
