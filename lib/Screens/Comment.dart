import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/seenPlaces.dart';
import 'package:lets_head_out/Lists/selectedPlaces.dart';
import 'package:lets_head_out/Lists/selectedRestaurants.dart';
import 'package:lets_head_out/Prefabs/CommentArea.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen>
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
        title: BoldText("Comment", 20, kwhite),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: true,
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

getSelectedPlaces() {
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
    ));
  }
  return places;
}

getSelectedRestaurants() {
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
    ));
  }
  return places;
}
