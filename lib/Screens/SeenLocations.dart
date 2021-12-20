import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Lists/seenPlaces.dart';
import 'package:lets_head_out/Lists/seenRestaurants.dart';
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: TabBar(
            labelColor: mainColor,
            unselectedLabelColor: kdarkBlue,
            labelStyle:
                TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
            controller: tabController,
            indicatorColor: mainColor,
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
            GridView(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(seenPlaces.length, (index) {
                return LocationsImage(
                  seenPlaces[index].id,
                  seenPlaces[index].imageUrl,
                  seenPlaces[index].name,
                  seenPlaces[index].location,
                  seenPlaces[index].description,
                  seenPlaces[index].rate,
                  seenPlaces[index].type,
                  seenPlaces[index].telephone,
                  seenPlaces[index].whoSee,
                  seenPlaces[index].hours,
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
              children: List.generate(seenRestaurant.length, (index) {
                return LocationsImage(
                  seenRestaurant[index].id,
                  seenRestaurant[index].imageUrl,
                  seenRestaurant[index].name,
                  seenRestaurant[index].location,
                  seenRestaurant[index].description,
                  seenRestaurant[index].rate,
                  seenRestaurant[index].type,
                  seenRestaurant[index].telephone,
                  seenRestaurant[index].whoSee,
                  seenRestaurant[index].hours,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
