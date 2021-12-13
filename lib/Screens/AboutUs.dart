import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/creators.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("About Us", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              CircleAvatar(
                backgroundColor: kgreyDark,
                backgroundImage: AssetImage(creators[0]["profileImage"]),
                radius: 60,
              ),
              BoldText(creators[0]["name"] + " " + creators[0]["surname"], 20,
                  kblack),
              NormalText(creators[0]["e-mail"], kblack, 20),
            ],
          ),
          SizedBox(height: 80.0),
          Column(
            children: [
              CircleAvatar(
                backgroundColor: kgreyDark,
                backgroundImage: AssetImage(creators[1]["profileImage"]),
                radius: 60,
              ),
              BoldText(creators[1]["name"] + " " + creators[1]["surname"], 20,
                  kblack),
              NormalText(creators[1]["e-mail"], kblack, 20),
            ],
          ),
        ],
      ),
    );
  }
}
