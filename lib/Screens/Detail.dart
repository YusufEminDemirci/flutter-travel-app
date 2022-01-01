import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/commentsList.dart';
import 'package:lets_head_out/Lists/selectedPlaces.dart';
import 'package:lets_head_out/Lists/selectedRestaurants.dart';
import 'package:lets_head_out/Models/comment.dart';
import 'package:lets_head_out/Prefabs/CityInfo.dart';
import 'package:lets_head_out/Prefabs/CommentDisplay.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';
import 'package:lets_head_out/Prefabs/PlaceLocationMap.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Prefabs/Comments.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final ScrollController scrollController = ScrollController();

class DetailScreen extends StatefulWidget {
  final String description;
  final Map hours;
  final String id;
  final String imageUrl;
  final String location;
  final String name;
  final String rate;
  final String telephone;
  final String type;
  final List whoSee;
  final String cityName;

  DetailScreen(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.whoSee,
    this.hours,
    this.cityName,
  );

  @override
  _DetailScreenState createState() => _DetailScreenState(
        this.id,
        this.imageUrl,
        this.name,
        this.location,
        this.description,
        this.rate,
        this.type,
        this.telephone,
        this.whoSee,
        this.hours,
        this.cityName,
      );
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  String description;
  Map hours;
  String id;
  String imageUrl;
  String location;
  String name;
  String rate;
  String telephone;
  String type;
  List whoSee;
  String cityName;

  _DetailScreenState(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.whoSee,
    this.hours,
    this.cityName,
  );

  @override
  TabController tabController;

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    getComments(location, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ))),
          Positioned(
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Positioned(
            child: SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * 0.62,
              minHeight: MediaQuery.of(context).size.height * 0.18,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              panel: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(38.0),
                      child: AppBar(
                        title: Column(
                          children: [
                            Container(
                                height: 3,
                                width: 80,
                                color: Colors.grey.shade300),
                            BoldText(name, 25.0, kblack),
                          ],
                        ),
                        centerTitle: true,
                        backgroundColor: kwhite,
                        elevation: 0,
                      ),
                    ),
                    backgroundColor: kwhite,
                    body: Scaffold(
                      backgroundColor: kwhite,
                      appBar: TabBar(
                        labelColor: mainColor,
                        unselectedLabelColor: kdarkBlue,
                        labelStyle: TextStyle(
                          fontFamily: "nunito",
                          fontWeight: FontWeight.bold,
                        ),
                        controller: tabController,
                        indicatorColor: mainColor,
                        tabs: <Widget>[
                          Tab(
                            text: "Information",
                            icon: Icon(FontAwesomeIcons.info),
                            height: 53,
                          ),
                          Tab(
                            text: "Location",
                            icon: Icon(FontAwesomeIcons.mapMarkedAlt),
                            height: 53,
                          ),
                          Tab(
                            text: "Reviews",
                            icon: Icon(FontAwesomeIcons.solidComment),
                            height: 53,
                          ),
                        ],
                      ),
                      body: Stack(
                        children: <Widget>[
                          TabBarView(
                            children: <Widget>[
                              CityInfo(
                                  telephone: telephone,
                                  hours: hours,
                                  description: description),
                              PlaceLocationMap(),
                              CommentDisplay(
                                rate: rate,
                              ),
                            ],
                            controller: tabController,
                          ),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          bool response = checkList(
                            id,
                            imageUrl,
                            name,
                            location,
                            description,
                            rate,
                            type,
                            telephone,
                            whoSee,
                            hours,
                            cityName,
                          );

                          if (response) {
                            popUpMessage(
                                context,
                                "This place added to Travel List",
                                FontAwesomeIcons.check);
                          } else if (!response) {
                            popUpMessage(
                                context,
                                "This place removed from Travel List",
                                FontAwesomeIcons.exclamation);
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: kwhite,
                        ),
                        backgroundColor: mainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

getComments(String cityId, String placeId) {
  final firestoreInstance = FirebaseFirestore.instance;

  return StreamBuilder<QuerySnapshot>(
    stream: firestoreInstance
        .collection("Cities")
        .doc("Gjp6AG8GF5DY0eL99Uc5")
        .collection("Places")
        .doc("MZUWZdKp6Rtzr3QFQIps")
        .collection("Comments")
        .snapshots(),
    builder: (context, snapshot) {
      final commentList = snapshot.data.docs;
      comments = [];

      for (var comment in commentList) {
        String _date = comment.data()["date"];
        String _id = comment.data()["id"];
        String _imageUrl = comment.data()["imageUrl"];
        String _message = comment.data()["message"];
        String _name = comment.data()["name"];
        String _rate = comment.data()["rate"];
        comments.add(CommentsImage(Comment(
          date: _date,
          id: _id,
          imageUrl: _imageUrl,
          message: _message,
          name: _name,
          rate: _rate,
        )));
      }
      return ListView(
        children: comments,
      );
    },
  );
}

checkList(
  String id,
  String imageUrl,
  String name,
  String location,
  String description,
  String rate,
  String type,
  String telephone,
  List whoSee,
  Map hours,
  String cityName,
) {
  if (selectedPlaces.length > 0) {
    for (int index = 0; index < selectedPlaces.length; index++) {
      if (id != selectedPlaces[index].id && type == "place") {
        selectedPlaces.add(LocationsImage(
          id,
          imageUrl,
          name,
          location,
          description,
          rate,
          type,
          telephone,
          whoSee,
          hours,
          cityName,
        ));
        return true;
      } else if (id == selectedPlaces[index].id && type == "place") {
        selectedPlaces.remove(selectedPlaces[index]);
        return false;
      }
    }
  } else if (selectedPlaces.length == 0 && type == "place") {
    selectedPlaces.add(LocationsImage(
      id,
      imageUrl,
      name,
      location,
      description,
      rate,
      type,
      telephone,
      whoSee,
      hours,
      cityName,
    ));
    return true;
  }
  if (selectedRestaurants.length > 0) {
    for (int index = 0; index < selectedRestaurants.length; index++) {
      if (id != selectedRestaurants[index].id && type == "restaurant") {
        selectedRestaurants.add(LocationsImage(
          id,
          imageUrl,
          name,
          location,
          description,
          rate,
          type,
          telephone,
          whoSee,
          hours,
          cityName,
        ));
        return true;
      } else if (id == selectedRestaurants[index].id && type == "restaurant") {
        selectedRestaurants.remove(selectedRestaurants[index]);
        return false;
      }
    }
  } else if (selectedRestaurants.length == 0 && type == "restaurant") {
    selectedRestaurants.add(LocationsImage(
      id,
      imageUrl,
      name,
      location,
      description,
      rate,
      type,
      telephone,
      whoSee,
      hours,
      cityName,
    ));
    return true;
  }
  return false;
}

Future<Object> popUpMessage(
    BuildContext context, String message, IconData icon) {
  return showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          child: SizedBox.expand(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoldText(message, 20, mainColor),
                Icon(
                  icon,
                  color: mainColor,
                  size: 30,
                ),
              ],
            ),
          ),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
