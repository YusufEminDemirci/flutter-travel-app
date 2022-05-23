import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Lists/places.dart';
import 'package:travel_food/Lists/restaurants.dart';
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

    setState(() {
      getPlacesInfo(cityId, cityName);
    });
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
            RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: GridView(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                children: List.generate(places.length, (index) {
                  return LocationsImage(
                      places[index].id,
                      places[index].imageUrl,
                      places[index].name,
                      places[index].location,
                      places[index].description,
                      places[index].rate,
                      places[index].type,
                      places[index].telephone,
                      places[index].latitude,
                      places[index].longitude,
                      places[index].whoSee,
                      places[index].hours,
                      cityName,
                      cityId);
                }),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: GridView(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                children: List.generate(restaurants.length, (index) {
                  return LocationsImage(
                      restaurants[index].id,
                      restaurants[index].imageUrl,
                      restaurants[index].name,
                      restaurants[index].location,
                      restaurants[index].description,
                      restaurants[index].rate,
                      restaurants[index].type,
                      restaurants[index].telephone,
                      restaurants[index].latitude,
                      restaurants[index].longitude,
                      restaurants[index].whoSee,
                      restaurants[index].hours,
                      cityName,
                      cityId);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

getPlacesInfo(String cityId, String cityName) async {
  final firestoreInstance = FirebaseFirestore.instance;
  places = [];
  restaurants = [];
  firestoreInstance
      .collection("Cities")
      .doc(cityId)
      .collection("Places")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String _id = result.data()["id"];
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      String _location = result.data()["location"];
      String _description = result.data()["description"];
      String _rate = result.data()["rate"];
      String _type = result.data()["type"];
      String _telephone = result.data()["telephone"];
      String _latitude = result.data()["latitude"];
      String _longitude = result.data()["longitude"];
      List _whoSee = [];
      Map _hours = result.data()["Hours"];

      if (_type == "place" && _location == cityId) {
        places.add(LocationsImage(
            _id,
            _imageUrl,
            _name,
            _location,
            _description,
            _rate,
            _type,
            _telephone,
            _latitude,
            _longitude,
            _whoSee,
            _hours,
            cityName,
            cityId));
      }
      if (_type == "restaurant" && _location == cityId) {
        restaurants.add(LocationsImage(
            _id,
            _imageUrl,
            _name,
            _location,
            _description,
            _rate,
            _type,
            _telephone,
            _latitude,
            _longitude,
            _whoSee,
            _hours,
            cityName,
            cityId));
      }
    });
  });
}
