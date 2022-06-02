import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_food/Prefabs/CityInfo.dart';
import 'package:travel_food/Prefabs/CommentDisplay.dart';
import 'package:travel_food/Prefabs/PlaceLocationMap.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final ScrollController scrollController = ScrollController();

class DetailScreen extends StatefulWidget {
  final String description;
  final Map hours;
  final String id;
  final String imageUrl;
  final String location;
  final String name;
  final String rate;
  final String telephone;
  String latitude;
  String longitude;
  final String type;
  final List whoSee;
  final String cityName;
  final String cityId;

  DetailScreen(
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
  _DetailScreenState createState() => _DetailScreenState(
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

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  String description;
  Map hours;
  String id;
  String imageUrl;
  String location;
  String name;
  String rate;
  String telephone;
  String latitude;
  String longitude;
  String type;
  List whoSee;
  String cityName;
  String cityId;

  _DetailScreenState(
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
                            fontFamily: "nunito",
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
                                CityInfo(
                                    telephone: telephone,
                                    hours: hours,
                                    description: description),
                                PlaceLocationMap(
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
                                CommentDisplay(cityId, id),
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

  print(userMail);

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

Future<Object> popUpMessage(
    BuildContext context, String message, IconData icon) {
  return showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          child: SizedBox.expand(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoldText(message, 20, kblack),
                Icon(
                  icon,
                  color: Colors.redAccent,
                  size: 30,
                ),
              ],
            ),
          ),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
