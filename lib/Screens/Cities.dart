import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/utils/CitiesImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/utils/imageContainer.dart';

class Cities extends StatefulWidget {
  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: BoldText("Cities", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 30.0,
                      right: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText(
                          "Which city would you like to visit?", 21.0, kblack),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      CitiesImage("assets/alger.jpg", "ADANA"),
                      SizedBox(
                        width: 28,
                      ),
                      CitiesImage("assets/tlemcen.jpg", "ADIYAMAN"),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: <Widget>[
                      CitiesImage("assets/adrar.jpg", "ANKARA"),
                      SizedBox(
                        width: 28,
                      ),
                      CitiesImage("assets/bedjaia.jpg", "BURSA"),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: <Widget>[
                      CitiesImage("assets/alger.jpg", "ÇANKIRI"),
                      SizedBox(
                        width: 28,
                      ),
                      CitiesImage("assets/tlemcen.jpg", "İSTANBUL"),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: <Widget>[
                      CitiesImage("assets/adrar.jpg", "KIRIKKALE"),
                      SizedBox(
                        width: 28,
                      ),
                      CitiesImage("assets/bedjaia.jpg", "ZONGULDAK"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
