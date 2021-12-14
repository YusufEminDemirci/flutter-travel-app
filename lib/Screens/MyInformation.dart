import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class MyInformation extends StatefulWidget {
  @override
  _MyInformationState createState() => _MyInformationState();
}

String _name;
String _surname;
String _email;
String _birthday;

class _MyInformationState extends State<MyInformation> {
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("My Information", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
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
                              BoldText(
                                  "$_name $_surname".toString(), 25.0, kblack),
                              Container(
                                height: 2,
                                width:
                                    ("$_name $_surname".length.toDouble()) * 20,
                                color: mainColor,
                              ),
                              SizedBox(height: 80.0),
                              profileItem(
                                  Icons.mail_rounded, _email.toString()),
                              profileItem(Icons.cake, _birthday.toString()),
                              SizedBox(height: 50.0),
                              profileItem(
                                  Icons.password_rounded, "Change Password"),
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
        onTap: () {
          if (text == "Change Password") {
            //TODO: change password
          }
        },
      ),
    );
  }
}

getUserInfo() {
  final firestoreInstance = FirebaseFirestore.instance;

  firestoreInstance.collection("Users").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      _name = result.data()["name"];
      _surname = result.data()["surname"];
      _email = result.data()["e-mail"];
      _birthday = result.data()["birthday"];
    });
  });
}
