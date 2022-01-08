import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Lists/places.dart';
import 'package:travel_food/Prefabs/Locations.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class Places extends StatefulWidget {
  final String cityId;
  final String cityName;

  Places(this.cityId, this.cityName);

  @override
  _PlacesState createState() => _PlacesState(this.cityId, this.cityName);
}

class _PlacesState extends State<Places> with SingleTickerProviderStateMixin {
  TabController tabController;
  final String cityId;
  final String cityName;

  _PlacesState(this.cityId, this.cityName);

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
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: Colors.transparent,
          title: BoldText("What are you, Looking for?", 22, dayMainColor),
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
                  left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(places.length, (index) {
                if (places[index].type == "place") {
                  return LocationsImage(
                    places[index].id,
                    places[index].imageUrl,
                    places[index].name,
                    places[index].location,
                    places[index].description,
                    places[index].rate,
                    places[index].type,
                    places[index].telephone,
                    places[index].whoSee,
                    places[index].hours,
                    cityName,
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
              children: List.generate(places.length, (index) {
                if (places[index].type == "restaurant") {
                  return LocationsImage(
                    places[index].id,
                    places[index].imageUrl,
                    places[index].name,
                    places[index].location,
                    places[index].description,
                    places[index].rate,
                    places[index].type,
                    places[index].telephone,
                    places[index].whoSee,
                    places[index].hours,
                    cityName,
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
