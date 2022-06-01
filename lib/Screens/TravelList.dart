import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Lists/selectedPlaces.dart';
import 'package:travel_food/Lists/selectedRestaurants.dart';
import 'package:travel_food/Prefabs/Locations.dart';
import 'package:travel_food/Prefabs/PlanPlace.dart';
import 'package:travel_food/Screens/TravelPlan.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class TravelList extends StatefulWidget {
  final String cityName;
  final String cityId;

  TravelList({
    this.cityName = "Adana",
    this.cityId = "",
  });
  @override
  _TravelListState createState() => _TravelListState(
        this.cityName,
        this.cityId,
      );
}

class _TravelListState extends State<TravelList>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;

  _TravelListState(
    this.cityName,
    this.cityId,
  );
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
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
                  .doc("yBeXEnvLJ1QlTxzqh8LM")
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
                        return PlanPlace(
                            snapshot.data.documents[index].data()["id"],
                            snapshot.data.documents[index].data()["imageUrl"],
                            snapshot.data.documents[index].data()["name"],
                            snapshot.data.documents[index].data()["location"],
                            snapshot.data.documents[index]
                                .data()["description"],
                            snapshot.data.documents[index].data()["rate"],
                            snapshot.data.documents[index].data()["type"],
                            snapshot.data.documents[index].data()["telephone"],
                            snapshot.data.documents[index].data()["latitude"],
                            snapshot.data.documents[index].data()["longitude"],
                            [],
                            snapshot.data.documents[index].data()["Hours"],
                            cityName,
                            cityId);
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
                  .doc("yBeXEnvLJ1QlTxzqh8LM")
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
                        return PlanPlace(
                            snapshot.data.documents[index].data()["id"],
                            snapshot.data.documents[index].data()["imageUrl"],
                            snapshot.data.documents[index].data()["name"],
                            snapshot.data.documents[index].data()["location"],
                            snapshot.data.documents[index]
                                .data()["description"],
                            snapshot.data.documents[index].data()["rate"],
                            snapshot.data.documents[index].data()["type"],
                            snapshot.data.documents[index].data()["telephone"],
                            snapshot.data.documents[index].data()["latitude"],
                            snapshot.data.documents[index].data()["longitude"],
                            [],
                            snapshot.data.documents[index].data()["Hours"],
                            cityName,
                            cityId);
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
      floatingActionButton: floatingButtonStatus(
        context,
        cityId,
        cityName,
        TravelMode.walking,
      ),
    );
  }
}

floatingButtonStatus(
  BuildContext context,
  String cityId,
  String cityName,
  TravelMode travelMode,
) {
  if (selectedPlaces.length > 0 || selectedRestaurants.length > 0) {
    return FloatingActionButton(
      onPressed: () {
        if (selectedPlaces.length > 0 || selectedRestaurants.length > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  new TravelPlan(cityName, cityId, travelMode),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your List is empty"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Icon(
        FontAwesomeIcons.arrowRight,
        color: kwhite,
      ),
      backgroundColor: dayMainColor,
    );
  }
}
