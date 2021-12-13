import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Lists/seenLocationsList.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';

class SeenLocations extends StatefulWidget {
  @override
  _SeenLocationsState createState() => _SeenLocationsState();
}

class _SeenLocationsState extends State<SeenLocations>
    with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("Seen Locations", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: TabBar(
          labelColor: kdarkBlue,
          labelStyle:
              TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
          controller: tabController,
          indicatorColor: mainColor,
          tabs: <Widget>[
            Tab(
              text: "Places",
              icon: Icon(Icons.house),
            ),
            Tab(
              text: "Restaurants",
              icon: Icon(Icons.food_bank),
            ),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0, top: 10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: getPlaces(),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0, top: 10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: getRestaurants(),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
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

getPlaces() {
  List<LocationsImage> getPlaces = [];
  for (int index = 0; index < seenLocations.length; index++) {
    if (seenLocations[index].type == "place") {
      getPlaces.add(LocationsImage(
        seenLocations[index].id,
        seenLocations[index].imageUrl,
        seenLocations[index].name,
        seenLocations[index].description,
        seenLocations[index].location,
        seenLocations[index].comment,
        seenLocations[index].rate,
        seenLocations[index].type,
        seenLocations[index].cityId,
      ));
    }
  }
  return getPlaces;
}

getRestaurants() {
  List<LocationsImage> getRestaurants = [];
  for (int index = 0; index < seenLocations.length; index++) {
    if (seenLocations[index].type == "restaurant") {
      getRestaurants.add(LocationsImage(
        seenLocations[index].id,
        seenLocations[index].imageUrl,
        seenLocations[index].name,
        seenLocations[index].description,
        seenLocations[index].location,
        seenLocations[index].comment,
        seenLocations[index].rate,
        seenLocations[index].type,
        seenLocations[index].cityId,
      ));
    }
  }
  return getRestaurants;
}
