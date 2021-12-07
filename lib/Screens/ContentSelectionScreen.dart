import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/utils/ContentSelectionImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/Screens/Places.dart';
import 'package:lets_head_out/Screens/Restaurants.dart';

class ContentSelectionScreen extends StatefulWidget {
  final String city;

  ContentSelectionScreen(this.city);
  @override
  _ContentSelectionScreenState createState() =>
      _ContentSelectionScreenState(city);
}

class _ContentSelectionScreenState extends State<ContentSelectionScreen> {
  String city;

  _ContentSelectionScreenState(this.city);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.amber,
              height: 100.0,
              width: 420.0,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          BoldText("What are you, Looking for?", 29.0, kblack),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 11.0, right: 6.0, bottom: 16.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Places(city)));
                            },
                            child: ContentSelectionImage(
                                "assets/alger.jpg", "PLACES"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Restaurants(city)));
                            },
                            child: ContentSelectionImage(
                                "assets/sheraton.jpg", "Restaurants"),
                          ),
                        ),
                      ),
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
