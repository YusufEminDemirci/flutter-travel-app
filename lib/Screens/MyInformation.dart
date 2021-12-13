import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/myInformation.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class MyInformation extends StatefulWidget {
  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("My Information", 35, kwhite),
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
                BoldText(myInfo["name"] + " " + myInfo["surname"], 20, kblack),
              ],
            ),
            Container(
              height: 2,
              color: kgreyFill,
            ),
            NormalText("E-Mail: " + myInfo["e-mail"], kblack, 20),
          ],
        ),
      ),
    );
  }
}
