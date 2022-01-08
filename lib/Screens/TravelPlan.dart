import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Lists/selectedPlaces.dart';
import 'package:travel_food/Lists/selectedRestaurants.dart';
import 'package:travel_food/Prefabs/CommentArea.dart';
import 'package:travel_food/Screens/Comment.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class TravelPlan extends StatefulWidget {
  final String cityId;
  final String cityName;

  TravelPlan(this.cityId, this.cityName);
  @override
  _TravelPlanState createState() => _TravelPlanState(this.cityId, cityName);
}

class _TravelPlanState extends State<TravelPlan>
    with SingleTickerProviderStateMixin {
  String cityId;
  String cityName;
  _TravelPlanState(this.cityId, this.cityName);

  @override
  void dispose() {
    super.dispose();
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
          title: BoldText("Travel Plan", 20, dayMainColor),
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
      body: Container(
        alignment: Alignment.center,
        //TODO: EDIT PROFILE !!!
        child: Text(
          "Coming soon...",
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new CommentScreen(cityId, cityName)));
        },
        child: Icon(
          FontAwesomeIcons.arrowRight,
          color: kwhite,
        ),
        backgroundColor: dayMainColor,
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
