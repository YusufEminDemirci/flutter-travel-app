import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/commentsList.dart';
import 'package:lets_head_out/Lists/selectedPlaces.dart';
import 'package:lets_head_out/Lists/selectedRestaurants.dart';
import 'package:lets_head_out/Models/location.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:lets_head_out/Prefabs/Comments.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
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
                                            NormalText(
                                                "444 44 44", kblack, 15.0),
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
                                                    "MONDAY - 10:00 / 18:00",
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "TUESDAY - 10:00 / 18:00",
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "WEDNESDEY - 10:00 / 18:00",
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "THURSDAY - 10:00 / 18:00",
                                                    kblack,
                                                    12.0),
                                                NormalText(
                                                    "FRIDAY - 10:00 / 18:00",
                                                    kblack,
                                                    12.0),
                                                NormalText("SATURDAY - CLOSED",
                                                    kblack, 12.0),
                                                NormalText("SUNDAY - CLOSED",
                                                    kblack, 12.0),
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
                                          fit: BoxFit.fill,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
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
                                                comments.length.toString() +
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
            ),
          ),
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
