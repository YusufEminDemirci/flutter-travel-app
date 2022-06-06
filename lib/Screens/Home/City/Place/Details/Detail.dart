import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../Utils/TextStyles.dart';
import '../../../../../Utils/consts.dart';
import 'Comment/Comment.dart';
import 'Info/Info.dart';
import 'Location/Map.dart';

final ScrollController scrollController = ScrollController();

class Detail extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final String rate;
  final String type;
  final String telephone;
  String latitude;
  String longitude;
  final List whoSee;
  final Map hours;
  final String cityName;
  final String cityId;

  Detail(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.latitude,
    this.longitude,
    this.whoSee,
    this.hours,
    this.cityName,
    this.cityId,
  );

  @override
  _DetailState createState() => _DetailState(
        this.id,
        this.imageUrl,
        this.name,
        this.location,
        this.description,
        this.rate,
        this.type,
        this.telephone,
        this.latitude,
        this.longitude,
        this.whoSee,
        this.hours,
        this.cityName,
        this.cityId,
      );
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  String id;
  String imageUrl;
  String name;
  String location;
  String description;
  String rate;
  String type;
  String telephone;
  String latitude;
  String longitude;
  List whoSee;
  Map hours;
  String cityName;
  String cityId;

  _DetailState(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.latitude,
    this.longitude,
    this.whoSee,
    this.hours,
    this.cityName,
    this.cityId,
  );

  @override
  TabController tabController;

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: BackButton(color: dayTextColor),
          backgroundColor: Colors.white70,
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          title: BoldText(name, 25.0, dayTextColor),
        ),
      ),
      backgroundColor: kwhite,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * 0.62,
              minHeight: MediaQuery.of(context).size.height * 0.10,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              panel: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                        height: 2.5, width: 80, color: Colors.grey.shade300),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.59,
                      child: Scaffold(
                        backgroundColor: kwhite,
                        appBar: TabBar(
                          labelColor: dayMainColor,
                          unselectedLabelColor: dayTextColor,
                          labelStyle: TextStyle(
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.bold,
                          ),
                          controller: tabController,
                          indicatorColor: dayMainColor,
                          tabs: <Widget>[
                            Tab(
                              text: "Information",
                              icon: Icon(FontAwesomeIcons.info),
                              height: 53,
                            ),
                            Tab(
                              text: "Location",
                              icon: Icon(FontAwesomeIcons.mapMarkedAlt),
                              height: 53,
                            ),
                            Tab(
                              text: "Reviews",
                              icon: Icon(FontAwesomeIcons.solidComment),
                              height: 53,
                            ),
                          ],
                        ),
                        body: Stack(
                          children: <Widget>[
                            TabBarView(
                              children: <Widget>[
                                Info(
                                    telephone: telephone,
                                    hours: hours,
                                    description: description),
                                PlaceMap(
                                  this.id,
                                  this.imageUrl,
                                  this.name,
                                  this.location,
                                  this.description,
                                  this.rate,
                                  this.type,
                                  this.telephone,
                                  this.latitude,
                                  this.longitude,
                                  this.whoSee,
                                  this.hours,
                                  this.cityId,
                                ),
                                Comment(cityId, id),
                              ],
                              controller: tabController,
                            ),
                          ],
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () async {
                            String response = await checkList(
                              id,
                              imageUrl,
                              name,
                              location,
                              description,
                              rate,
                              type,
                              telephone,
                              latitude,
                              longitude,
                              whoSee,
                              hours,
                              cityName,
                              cityId,
                              context,
                            );

                            if (response == "Added") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(name + " added to list"),
                                  backgroundColor: Colors.greenAccent,
                                ),
                              );
                            } else if (response == "Removed") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(name + " removed from list"),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            } else if (response ==
                                "Places from different cities cannot be added to the list") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: kwhite,
                          ),
                          backgroundColor: dayMainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

checkList(
  String id,
  String imageUrl,
  String name,
  String location,
  String description,
  String rate,
  String type,
  String telephone,
  String latitude,
  String longitude,
  List whoSee,
  Map hours,
  String cityName,
  String cityId,
  BuildContext context,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userMail = prefs.getString("userEmail");

  FirebaseFirestore.instance
      .collection('Users')
      .doc(userMail)
      .collection('selected')
      .get()
      .then((value) => {
            if (value.docs.length > 0)
              {
                if (cityId != value.docs[0]["cityId"])
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Places from different cities cannot be added to the list"),
                        backgroundColor: Colors.redAccent,
                      ),
                    )
                  }
                else if (id == value.docs[0]["id"])
                  {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userMail)
                        .collection('selected')
                        .doc(id)
                        .delete(),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(name + " removed"),
                        backgroundColor: Colors.redAccent,
                      ),
                    )
                  }
                else
                  {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userMail)
                        .collection('selected')
                        .doc(id)
                        .set({
                      "id": id,
                      "imageUrl": imageUrl,
                      "name": name,
                      "location": location,
                      "description": description,
                      "rate": rate,
                      "type": type,
                      "telephone": telephone,
                      "latitude": latitude,
                      "longitude": longitude,
                      "whoSee": whoSee,
                      "hours": hours,
                      "cityName": cityName,
                      "cityId": cityId
                    }),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(name + " added"),
                        backgroundColor: Colors.greenAccent,
                      ),
                    )
                  }
              }
            else
              {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userMail)
                    .collection('selected')
                    .doc(id)
                    .set({
                  "id": id,
                  "imageUrl": imageUrl,
                  "name": name,
                  "location": location,
                  "description": description,
                  "rate": rate,
                  "type": type,
                  "telephone": telephone,
                  "latitude": latitude,
                  "longitude": longitude,
                  "whoSee": whoSee,
                  "hours": hours,
                  "cityName": cityName,
                  "cityId": cityId
                }),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(name + " added"),
                    backgroundColor: Colors.greenAccent,
                  ),
                )
              }
          });
}
