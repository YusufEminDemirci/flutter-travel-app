import 'package:flutter/material.dart';
import 'package:travel_food/Lists/creators.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

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
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: BackButton(color: dayTextColor),
          backgroundColor: kwhite,
          title: BoldText("About Us", 35, dayTextColor),
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
                backgroundImage: AssetImage("assets/kku-logo.jpeg"),
                radius: 60,
              ),
              BoldText("KIRIKKALE ÜNİVERSİTESİ", 20, dayTextColor),
              NormalText("2021-2022", dayTextColor, 20),
              NormalText("Bitirme Projesi 1-2", dayTextColor, 20),
            ],
          ),
          SizedBox(height: 80.0),
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
                  dayTextColor),
              NormalText(creators[0]["e-mail"], dayTextColor, 20),
            ],
          ),
        ],
      ),
    );
  }
}
