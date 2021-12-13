import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/restaurants.dart';
import 'package:lets_head_out/Lists/places.dart';
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
        backgroundColor: mainColor,
        title: BoldText("What are you, Looking for?", 20, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: TabBar(
          labelColor: mainColor,
          unselectedLabelColor: kdarkBlue,
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
              children: List.generate(places.length, (index) {
                if (places[index].cityId == cityId) {
                  return LocationsImage(
                    places[index].id,
                    places[index].imageUrl,
                    places[index].name,
                    places[index].location,
                    places[index].description,
                    places[index].comment,
                    places[index].rate,
                    places[index].type,
                    places[index].cityId,
                  );
                } else {
                  return Container();
                }
              }),
            ),
            GridView(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(restaurants.length, (index) {
                if (places[index].cityId == cityId) {
                  return LocationsImage(
                    restaurants[index].id,
                    restaurants[index].imageUrl,
                    restaurants[index].name,
                    restaurants[index].location,
                    restaurants[index].description,
                    restaurants[index].comment,
                    restaurants[index].rate,
                    restaurants[index].type,
                    restaurants[index].cityId,
                  );
                } else {
                  return Container();
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
