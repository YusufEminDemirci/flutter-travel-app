import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Utils/TextStyles.dart';
import '../../../../../Utils/consts.dart';
import 'Comment_Prefab.dart';
import 'Finish/Finish.dart';

class Comment extends StatefulWidget {
  final String cityId;

  Comment(
    this.cityId,
  );
  @override
  _CommentState createState() => _CommentState(
        this.cityId,
      );
}

String userMail;

class _CommentState extends State<Comment> with SingleTickerProviderStateMixin {
  String cityId;
  _CommentState(
    this.cityId,
  );
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    getUserMail();
    super.initState();
  }

  getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString("userEmail");
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
          leading: BackButton(color: dayTextColor),
          backgroundColor: Colors.transparent,
          title: BoldText("Comment", 20, dayTextColor),
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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userMail)
                  .collection("selected")
                  .where("type", isEqualTo: "place")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Comment_Prefab(
                          snapshot.data.documents[index].data()["id"],
                          snapshot.data.documents[index].data()["imageUrl"],
                          snapshot.data.documents[index].data()["name"],
                          snapshot.data.documents[index].data()["location"],
                          snapshot.data.documents[index].data()["rate"],
                          "",
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userMail)
                  .collection("selected")
                  .where("type", isEqualTo: "restaurant")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Comment_Prefab(
                          snapshot.data.documents[index].data()["id"],
                          snapshot.data.documents[index].data()["imageUrl"],
                          snapshot.data.documents[index].data()["name"],
                          snapshot.data.documents[index].data()["location"],
                          snapshot.data.documents[index].data()["rate"],
                          "",
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dayMainColor,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => new Finish(),
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
