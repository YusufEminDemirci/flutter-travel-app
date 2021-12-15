import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/selectedPlaces.dart';
import 'package:lets_head_out/Lists/selectedRestaurants.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
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
        backgroundColor: mainColor,
        title: BoldText("My Plan", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
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
            GridView(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(selectedPlaces.length, (index) {
                return LocationsImage(
                  selectedPlaces[index].id,
                  selectedPlaces[index].imageUrl,
                  selectedPlaces[index].name,
                  selectedPlaces[index].location,
                  selectedPlaces[index].description,
                  selectedPlaces[index].comment,
                  selectedPlaces[index].rate,
                  selectedPlaces[index].type,
                  selectedPlaces[index].cityId,
                );
              }),
            ),
            GridView(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(selectedRestaurants.length, (index) {
                return LocationsImage(
                  selectedRestaurants[index].id,
                  selectedRestaurants[index].imageUrl,
                  selectedRestaurants[index].name,
                  selectedRestaurants[index].location,
                  selectedRestaurants[index].description,
                  selectedRestaurants[index].comment,
                  selectedRestaurants[index].rate,
                  selectedRestaurants[index].type,
                  selectedRestaurants[index].cityId,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
