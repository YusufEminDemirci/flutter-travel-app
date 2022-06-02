import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/place.dart';
import '../../../Utils/TextStyles.dart';
import '../../../Utils/consts.dart';
import 'Place_Prefab.dart';
import 'Plan/Plan.dart';

class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

String userMail;

class _TravelState extends State<Travel> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
    getUserMail();
  }

  getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString("userEmail");
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white70,
          title: BoldText("My Plan", 35, dayTextColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: TabBar(
            labelColor: dayMainColor,
            unselectedLabelColor: dayTextColor,
            labelStyle:
                TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
            controller: tabController,
            indicatorColor: dayMainColor,
            tabs: <Widget>[
              Tab(
                text: "Places",
                icon: Icon(FontAwesomeIcons.tree),
              ),
              Tab(
                text: "Restaurants",
                icon: Icon(FontAwesomeIcons.pizzaSlice),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userMail)
                  .collection("selected")
                  .where("type", isEqualTo: "place")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Place_Prefab(
                          snapshot.data.documents[index].data()["id"],
                          snapshot.data.documents[index].data()["imageUrl"],
                          snapshot.data.documents[index].data()["name"],
                          snapshot.data.documents[index].data()["cityId"],
                          snapshot.data.documents[index].data()["cityName"],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userMail)
                  .collection("selected")
                  .where("type", isEqualTo: "restaurant")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Place_Prefab(
                          snapshot.data.documents[index].data()["id"],
                          snapshot.data.documents[index].data()["imageUrl"],
                          snapshot.data.documents[index].data()["name"],
                          snapshot.data.documents[index].data()["cityId"],
                          snapshot.data.documents[index].data()["cityName"],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(userMail)
              .collection("selected")
              .get()
              .then((querySnapshot) {
            if (querySnapshot.docs.length > 0) {
              String cityId = querySnapshot.docs[0].data()["location"];

              List<PlaceModel> travelList = [];

              querySnapshot.docs.forEach((element) {
                travelList.add(
                  PlaceModel(
                    element.data()["id"],
                    element.data()["imageUrl"],
                    element.data()["name"],
                    element.data()["location"],
                    element.data()["description"],
                    element.data()["rate"],
                    element.data()["type"],
                    element.data()["telephone"],
                    element.data()["latitude"],
                    element.data()["longitude"],
                    element.data()["whoSee"],
                    element.data()["hours"],
                  ),
                );
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      new Plan(travelList, cityId, TravelMode.driving),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Your list is empty, first you need to add a place to your list"),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          });
        },
        child: Icon(
          FontAwesomeIcons.arrowRight,
          color: kwhite,
        ),
        backgroundColor: dayMainColor,
      ),
    );
  }
}
