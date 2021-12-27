import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Lists/selectedPlaces.dart';
import 'package:lets_head_out/Lists/selectedRestaurants.dart';
import 'package:lets_head_out/Models/comment.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Prefabs/Comments.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

List<CommentsImage> commentsList = [];
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
    checkComments(location, id);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _getData() async {
      setState(() {
        checkComments(location, id);
      });
    }

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
              maxHeight: MediaQuery.of(context).size.height * 0.6,
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
                      preferredSize: Size.fromHeight(25.0),
                      child: AppBar(
                        title: BoldText(name, 25.0, kblack),
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    backgroundColor: kwhite,
                    body: Scaffold(
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
                          Tab(text: "Information"),
                          Tab(text: "Location"),
                          Tab(text: "Reviews"),
                        ],
                      ),
                      body: Stack(
                        children: <Widget>[
                          TabBarView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BoldText(
                                                "Telephone: ", 20.0, kblack),
                                            NormalText(telephone, kblack, 15.0),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 2,
                                          color: kgreyFill,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BoldText("Hours: ", 20.0, kblack),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                NormalText(
                                                    "MONDAY / " +
                                                        hours["Monday"],
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "TUESDAY / " +
                                                        hours["Tuesday"],
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "WEDNESDEY / " +
                                                        hours["Wednesday"],
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "THURSDAY / " +
                                                        hours["Thursday"],
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "FRIDAY / " +
                                                        hours["Friday"],
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "SATURDAY / " +
                                                        hours["Saturday"],
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "SUNDAY / " +
                                                        hours["Sunday"],
                                                    kblack,
                                                    12.0),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 2,
                                      color: kgreyFill,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        BoldText(
                                            "About this place", 20.0, kblack),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    NormalText(description, kblack, 12.0),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, left: 16.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 20.0),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          "assets/plazamap.png",
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            BoldText(
                                                commentsList.length.toString() +
                                                    " Reviews",
                                                20.0,
                                                kblack),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: mainColor,
                                                  size: 25.0,
                                                ),
                                                BoldText("$rate Stars", 14.0,
                                                    korange),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 2,
                                          color: kgreyFill,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        RefreshIndicator(
                                          onRefresh: _getData,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            controller: scrollController,
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            itemCount: commentsList.length,
                                            itemBuilder: (context, index) {
                                              return commentsList[index];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

checkComments(String cityId, String placeId) {
  final firestoreInstance = FirebaseFirestore.instance;
  firestoreInstance
      .collection("Cities")
      .doc(cityId)
      .collection("Places")
      .doc(placeId)
      .collection("Comments")
      .get()
      .then(
    (querySnapshot) {
      querySnapshot.docs.forEach((result) {
        String _date = result.data()["date"];
        String _id = result.data()["id"];
        String _imageUrl = result.data()["imageUrl"];
        String _message = result.data()["message"];
        String _name = result.data()["name"];
        String _rate = result.data()["rate"];
        for (int index = 0; index < commentsList.length; index++) {
          if (commentsList[index].comment.name != _name) {
            commentsList.add(CommentsImage(Comment(
              date: _date,
              id: _id,
              imageUrl: _imageUrl,
              message: _message,
              name: _name,
              rate: _rate,
            )));
          }
        }
      });
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

Future<void> _refresh() {
  return Future.delayed(Duration(seconds: 1));
}
