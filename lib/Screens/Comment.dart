import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Lists/selectedPlaces.dart';
import 'package:travel_food/Lists/selectedRestaurants.dart';
import 'package:travel_food/Prefabs/CommentArea.dart';
import 'package:travel_food/Screens/TravelFinished.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class CommentScreen extends StatefulWidget {
  final String cityName;
  final String cityId;

  CommentScreen(
    this.cityName,
    this.cityId,
  );
  @override
  _CommentScreenState createState() => _CommentScreenState(
        this.cityName,
        this.cityId,
      );
}

class _CommentScreenState extends State<CommentScreen>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;
  _CommentScreenState(
    this.cityName,
    this.cityId,
  );
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
          backgroundColor: Colors.transparent,
          title: BoldText("Comment", 20, dayMainColor),
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 25.0),
              child: ListView.builder(
                itemCount: selectedPlaces.length,
                itemBuilder: (context, index) {
                  return CommentArea(
                    selectedPlaces[index].id,
                    selectedPlaces[index].imageUrl,
                    selectedPlaces[index].name,
                    selectedPlaces[index].location,
                    selectedPlaces[index].description,
                    selectedPlaces[index].rate,
                    selectedPlaces[index].type,
                    selectedPlaces[index].telephone,
                    selectedPlaces[index].whoSee,
                    selectedPlaces[index].hours,
                    cityName,
                    cityId,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 25.0),
              child: ListView.builder(
                itemCount: selectedRestaurants.length,
                itemBuilder: (context, index) {
                  return CommentArea(
                    selectedRestaurants[index].id,
                    selectedRestaurants[index].imageUrl,
                    selectedRestaurants[index].name,
                    selectedRestaurants[index].location,
                    selectedRestaurants[index].description,
                    selectedRestaurants[index].rate,
                    selectedRestaurants[index].type,
                    selectedRestaurants[index].telephone,
                    selectedRestaurants[index].whoSee,
                    selectedRestaurants[index].hours,
                    cityName,
                    cityId,
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dayMainColor,
        onPressed: () {
          selectedPlaces = [];
          selectedRestaurants = [];
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => new TravelFinished(),
            ),
            ModalRoute.withName("/Home"),
          );
        },
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

getSelectedPlaces(String cityId, String cityName) {
  List<Widget> places = [];
  for (int index = 0; index < selectedPlaces.length; index) {
    places.add(CommentArea(
      selectedPlaces[index].id,
      selectedPlaces[index].imageUrl,
      selectedPlaces[index].name,
      selectedPlaces[index].location,
      selectedPlaces[index].description,
      selectedPlaces[index].rate,
      selectedPlaces[index].type,
      selectedPlaces[index].telephone,
      selectedPlaces[index].whoSee,
      selectedPlaces[index].hours,
      cityId,
      cityName,
    ));
  }
  return places;
}

getSelectedRestaurants(String cityId, String cityName) {
  List<Widget> places = [];
  for (int index = 0; index < selectedRestaurants.length; index) {
    places.add(CommentArea(
      selectedRestaurants[index].id,
      selectedRestaurants[index].imageUrl,
      selectedRestaurants[index].name,
      selectedRestaurants[index].location,
      selectedRestaurants[index].description,
      selectedRestaurants[index].rate,
      selectedRestaurants[index].type,
      selectedRestaurants[index].telephone,
      selectedRestaurants[index].whoSee,
      selectedRestaurants[index].hours,
      cityId,
      cityName,
    ));
  }
  return places;
}
