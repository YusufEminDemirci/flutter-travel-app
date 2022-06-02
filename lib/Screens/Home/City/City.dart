import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Utils/TextStyles.dart';
import '../../../Utils/consts.dart';
import 'City_Prefab.dart';

class City extends StatefulWidget {
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white70,
          title: BoldText("Türkiye", 35, dayTextColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Cities").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return City_Prefab(
                    snapshot.data.documents[index].data()["id"],
                    snapshot.data.documents[index].data()["imageUrl"],
                    snapshot.data.documents[index].data()["name"],
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
