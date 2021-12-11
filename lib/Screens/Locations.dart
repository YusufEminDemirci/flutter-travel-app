import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/locationsList.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class Places extends StatefulWidget {
  final String cityId;

  Places(this.cityId);

  @override
  _PlacesState createState() => _PlacesState(this.cityId);
}

class _PlacesState extends State<Places> with SingleTickerProviderStateMixin {
  TabController tabController;
  final String cityId;

  _PlacesState(this.cityId);

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
        backgroundColor: Colors.amber,
        title: BoldText("What are you, Looking for?", 20, kwhite),
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
          indicatorColor: Colors.amber,
          tabs: <Widget>[
            Tab(text: "Places"),
            Tab(text: "Restaurants"),
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
                          height: 15,
                        ),
                        Column(
                          children: getPlaces(cityId),
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
                          height: 15,
                        ),
                        Column(
                          children: getRestaurants(cityId),
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

getPlaces(String cityId) {
  List<LocationsImage> getPlaces = [];
  for (int index = 0; index < locations.length; index++) {
    if (locations[index].cityId == cityId && locations[index].type == "place") {
      getPlaces.add(LocationsImage(
        locations[index].id,
        locations[index].imageUrl,
        locations[index].name,
        locations[index].location,
        locations[index].description,
        locations[index].comment,
        locations[index].rate,
        locations[index].type,
        locations[index].cityId,
      ));
    }
  }
  return getPlaces;
}

getRestaurants(String cityId) {
  List<LocationsImage> getRestaurants = [];
  for (int index = 0; index < locations.length; index++) {
    if (locations[index].cityId == cityId &&
        locations[index].type == "restaurant") {
      getRestaurants.add(LocationsImage(
        locations[index].id,
        locations[index].imageUrl,
        locations[index].name,
        locations[index].location,
        locations[index].description,
        locations[index].comment,
        locations[index].rate,
        locations[index].type,
        locations[index].cityId,
      ));
    }
  }
  return getRestaurants;
}
