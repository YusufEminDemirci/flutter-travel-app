import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Lists/selectedLocationsList.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';

class TravelList extends StatefulWidget {
  @override
  _TravelListState createState() => _TravelListState();
}

class _TravelListState extends State<TravelList>
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
        backgroundColor: Colors.amber,
        title: BoldText("My Plan", 35, kwhite),
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
  for (int index = 0; index < selectedLocations.length; index++) {
    if (selectedLocations[index].type == "place") {
      getPlaces.add(LocationsImage(
        selectedLocations[index].id,
        selectedLocations[index].imageUrl,
        selectedLocations[index].name,
        selectedLocations[index].description,
        selectedLocations[index].location,
        selectedLocations[index].comment,
        selectedLocations[index].rate,
        selectedLocations[index].type,
        selectedLocations[index].cityId,
      ));
    }
  }
  return getPlaces;
}

getRestaurants() {
  List<LocationsImage> getRestaurants = [];
  for (int index = 0; index < selectedLocations.length; index++) {
    if (selectedLocations[index].type == "restaurant") {
      getRestaurants.add(LocationsImage(
        selectedLocations[index].id,
        selectedLocations[index].imageUrl,
        selectedLocations[index].name,
        selectedLocations[index].description,
        selectedLocations[index].location,
        selectedLocations[index].comment,
        selectedLocations[index].rate,
        selectedLocations[index].type,
        selectedLocations[index].cityId,
      ));
    }
  }
  return getRestaurants;
}
