import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/selectedPlaces.dart';
import 'package:lets_head_out/Screens/TravelPlan.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';

class TravelList extends StatefulWidget {
  final String cityName;
  final String cityId;

  TravelList({this.cityId = "", this.cityName = "Adana"});
  @override
  _TravelListState createState() =>
      _TravelListState(this.cityId, this.cityName);
}

class _TravelListState extends State<TravelList>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;

  _TravelListState(this.cityId, this.cityName);
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
          preferredSize: Size.fromHeight(30),
          child: AppBar(
            backgroundColor: kwhite,
            title: BoldText("My Plan", 35, dayMainColor),
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
                children: List.generate(selectedPlaces.length, (index) {
                  if (selectedPlaces[index].type == "place") {
                    return LocationsImage(
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
                children: List.generate(selectedPlaces.length, (index) {
                  if (selectedPlaces[index].type == "restaurant") {
                    return LocationsImage(
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
                    );
                  } else {
                    return Container();
                  }
                }),
              )
            ],
          ),
        ),
        floatingActionButton: floatingButtonStatus(context, cityId, cityName));
  }
}

floatingButtonStatus(BuildContext context, String cityId, String cityName) {
  if (selectedPlaces.length > 0) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new TravelPlan(cityId, cityName)));
      },
      child: Icon(
        FontAwesomeIcons.arrowRight,
        color: kwhite,
      ),
      backgroundColor: dayMainColor,
    );
  }
}
