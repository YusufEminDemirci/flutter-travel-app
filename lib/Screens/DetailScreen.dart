import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/commentsList.dart';
import 'package:lets_head_out/utils/Buttons.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/Lists/selectedLocationsList.dart';
import 'package:lets_head_out/utils/locationModel.dart';
import 'package:lets_head_out/utils/CommentsImage.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final String comment;
  final String rate;
  final String type;
  final String cityId;

  DetailScreen(this.id, this.imageUrl, this.name, this.location,
      this.description, this.comment, this.rate, this.type, this.cityId);
  @override
  _DetailScreenState createState() => _DetailScreenState(
      this.id,
      this.imageUrl,
      this.name,
      this.location,
      this.description,
      this.comment,
      this.rate,
      this.type,
      this.cityId);
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final String comment;
  final String rate;
  final String type;
  final String cityId;

  _DetailScreenState(this.id, this.imageUrl, this.name, this.location,
      this.description, this.comment, this.rate, this.type, this.cityId);
  @override
  TabController tabController;

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
                child: Image.asset(imageUrl)),
          ),
          Positioned(
            top: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Scaffold(
                  appBar: TabBar(
                    labelColor: kdarkBlue,
                    labelStyle: TextStyle(
                        fontFamily: "nunito", fontWeight: FontWeight.bold),
                    controller: tabController,
                    indicatorColor: Colors.amber,
                    tabs: <Widget>[
                      Tab(text: "Information"),
                      Tab(text: "Location"),
                      Tab(text: "Reviews"),
                    ],
                  ),
                  backgroundColor: kwhite,
                  body: Stack(
                    children: <Widget>[
                      TabBarView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BoldText(name, 20.0, kblack),
                                Row(
                                  children: <Widget>[
                                    BoldText("$rate Stars", 12.0, korange),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Icon(
                                      Icons.location_on,
                                      color: kgreyDark,
                                      size: 15.0,
                                    ),
                                    NormalText(location, kgreyDark, 15.0),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
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
                                    BoldText("About this place", 20.0, kblack),
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
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 16.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  BoldText("Location", 20.0, kblack),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/plazamap.png",
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              90,
                                      width: MediaQuery.of(context).size.width,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        BoldText("Reviews", 20.0, kblack),
                                        BoldText("See all", 16, kdarkBlue),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            color: korange,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: kwhite,
                                                size: 15.0,
                                              ),
                                              BoldText(rate.toString(), 15.0,
                                                  kwhite),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        NormalText(
                                          comments.length.toString() +
                                              " Reviews",
                                          kgreyDark,
                                          14,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      children: getComments(id),
                                    )
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
                ),
              ),
            ),
          ),
          Positioned(
              top: 625,
              left: 30,
              child: WideButton(
                "Add to list",
                () {
                  selectedLocations.add(
                    Location(
                      imageUrl: this.imageUrl,
                      name: this.name,
                      type: this.type,
                      description: this.description,
                      location: this.location,
                      comment: this.comment,
                      rate: this.rate,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  Column equipmentsItem(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          icon,
          color: kdarkBlue,
        ),
        NormalText(text, kdarkBlue, 12)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}

getComments(String locationId) {
  List<CommentsImage> getComments = [];
  for (int index = 0; index < comments.length; index++) {
    if (comments[index].locationId == locationId) {
      getComments.add(CommentsImage(comments[index]));
    }
  }
  return getComments;
}
