import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:travel_food/Lists/seenPlaces.dart';
import 'package:travel_food/Prefabs/Locations.dart';

class SeenLocations extends StatefulWidget {
  final String cityName;
  final String cityId;

  SeenLocations({this.cityName = "", this.cityId = ""});

  @override
  _SeenLocationsState createState() =>
      _SeenLocationsState(this.cityName, this.cityId);
}

class _SeenLocationsState extends State<SeenLocations>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;

  _SeenLocationsState(this.cityName, this.cityId);
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
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: kwhite,
          title: BoldText("Seen Locations", 35, dayMainColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: TabBar(
            labelColor: dayMainColor,
            unselectedLabelColor: kdarkBlue,
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
            GridView(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(seenPlaces.length, (index) {
                if (seenPlaces[index].type == "place") {
                  return LocationsImage(
                      seenPlaces[index].id,
                      seenPlaces[index].imageUrl,
                      seenPlaces[index].name,
                      seenPlaces[index].location,
                      seenPlaces[index].description,
                      seenPlaces[index].rate,
                      seenPlaces[index].type,
                      seenPlaces[index].telephone,
                      seenPlaces[index].latitude,
                      seenPlaces[index].longitude,
                      seenPlaces[index].whoSee,
                      seenPlaces[index].hours,
                      cityName,
                      cityId);
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
              children: List.generate(seenPlaces.length, (index) {
                if (seenPlaces[index].type == "place") {
                  return LocationsImage(
                      seenPlaces[index].id,
                      seenPlaces[index].imageUrl,
                      seenPlaces[index].name,
                      seenPlaces[index].location,
                      seenPlaces[index].description,
                      seenPlaces[index].rate,
                      seenPlaces[index].type,
                      seenPlaces[index].telephone,
                      seenPlaces[index].latitude,
                      seenPlaces[index].longitude,
                      seenPlaces[index].whoSee,
                      seenPlaces[index].hours,
                      cityName,
                      cityId);
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
