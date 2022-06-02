import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Utils/TextStyles.dart';
import '../../../../../../Utils/consts.dart';
import '../../../../Home.dart';

class Finish extends StatefulWidget {
  @override
  _FinishState createState() => new _FinishState();
}

class _FinishState extends State<Finish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: BoldText("Travel Finished", 35, dayMainColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/two.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "We hope your trip went well !",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: dayTextColor),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dayMainColor,
        onPressed: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => new Home(),
            ),
            ModalRoute.withName("/Home"),
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          String userMail = prefs.getString("userEmail");

          FirebaseFirestore.instance
              .collection('Users')
              .doc(userMail)
              .collection('selected')
              .get()
              .then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
          });
        },
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
