import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Lists/selectedPlaces.dart';
import 'package:travel_food/Lists/selectedRestaurants.dart';
import 'package:travel_food/Prefabs/PlanPlace.dart';
import 'package:travel_food/Screens/TravelPlan.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class TravelList extends StatefulWidget {
  final String cityName;
  final String cityId;

  TravelList({
    this.cityName = "Adana",
    this.cityId = "",
  });
  @override
  _TravelListState createState() => _TravelListState(
        this.cityName,
        this.cityId,
      );
}

class _TravelListState extends State<TravelList>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;

  _TravelListState(
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white70,
          title: BoldText("My Plan", 35, dayTextColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: TabBar(
            labelColor: dayMainColor,
            unselectedLabelColor: dayTextColor,
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
              children: List.generate(selectedPlaces.length, (index) {
                return PlanPlace(
                    selectedPlaces[index].id,
                    selectedPlaces[index].imageUrl,
                    selectedPlaces[index].name,
                    selectedPlaces[index].location,
                    selectedPlaces[index].description,
                    selectedPlaces[index].rate,
                    selectedPlaces[index].type,
                    selectedPlaces[index].telephone,
                    selectedPlaces[index].latitude,
                    selectedPlaces[index].longitude,
                    selectedPlaces[index].whoSee,
                    selectedPlaces[index].hours,
                    cityName,
                    cityId);
              }),
            ),
            GridView(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(selectedRestaurants.length, (index) {
                return PlanPlace(
                    selectedRestaurants[index].id,
                    selectedRestaurants[index].imageUrl,
                    selectedRestaurants[index].name,
                    selectedRestaurants[index].location,
                    selectedRestaurants[index].description,
                    selectedRestaurants[index].rate,
                    selectedRestaurants[index].type,
                    selectedRestaurants[index].telephone,
                    selectedRestaurants[index].latitude,
                    selectedRestaurants[index].longitude,
                    selectedRestaurants[index].whoSee,
                    selectedRestaurants[index].hours,
                    cityName,
                    cityId);
              }),
            )
          ],
        ),
      ),
      floatingActionButton: floatingButtonStatus(
        context,
        cityId,
        cityName,
        TravelMode.walking,
      ),
    );
  }
}

floatingButtonStatus(
  BuildContext context,
  String cityId,
  String cityName,
  TravelMode travelMode,
) {
  if (selectedPlaces.length > 0 || selectedRestaurants.length > 0) {
    return FloatingActionButton(
      onPressed: () {
        if (selectedPlaces.length > 0 || selectedRestaurants.length > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  new TravelPlan(cityName, cityId, travelMode),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your List is empty"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Icon(
        FontAwesomeIcons.arrowRight,
        color: kwhite,
      ),
      backgroundColor: dayMainColor,
    );
  }
}
