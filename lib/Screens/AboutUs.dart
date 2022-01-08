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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: kwhite,
          title: BoldText("About Us", 35, dayMainColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              CircleAvatar(
                backgroundColor: kgreyDark,
                backgroundImage: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/WhatsApp%20Image%202021-12-17%20at%2015.51.24.jpeg?alt=media&token=d48e34d1-6978-4c9b-bd80-a7e735b7b60d",
                ),
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
