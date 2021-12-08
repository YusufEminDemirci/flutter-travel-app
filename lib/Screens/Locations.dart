import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/locationsList.dart';
import 'package:lets_head_out/utils/LocationsImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';

class Places extends StatefulWidget {
  final String city;

  Places(this.city);

  @override
  _PlacesState createState() => _PlacesState(this.city);
}

class _PlacesState extends State<Places> with SingleTickerProviderStateMixin {
  TabController tabController;
  final String city;

  _PlacesState(this.city);

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
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: BoldText("Places", 20.0, kblack),
                          ),
                        ),
                        Column(
                          children: getPlaces(city),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: BoldText("Restaurant", 20.0, kblack),
                          ),
                        ),
                        Column(
                          children: getRestaurants(city),
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

getPlaces(String city) {
  List<LocationsImage> getPlaces = [];
  for (int index = 0; index < locations.length; index++) {
    if (locations[index].location.toLowerCase() == city.toLowerCase() &&
        locations[index].type == "place") {
      getPlaces.add(LocationsImage(
        locations[index].imageUrl,
        locations[index].name,
        locations[index].location,
        locations[index].description,
        locations[index].comment,
        locations[index].rate,
        locations[index].type,
      ));
    }
  }
  return getPlaces;
}

getRestaurants(String city) {
  List<LocationsImage> getRestaurants = [];
  for (int index = 0; index < locations.length; index++) {
    if (locations[index].location.toLowerCase() == city.toLowerCase() &&
        locations[index].type == "restaurant") {
      getRestaurants.add(LocationsImage(
        locations[index].imageUrl,
        locations[index].name,
        locations[index].location,
        locations[index].description,
        locations[index].comment,
        locations[index].rate,
        locations[index].type,
      ));
    }
  }
  return getRestaurants;
}
