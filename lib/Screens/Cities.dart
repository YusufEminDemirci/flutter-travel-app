import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_food/Prefabs/Cities.dart';
import 'package:travel_food/Prefabs/SearchBar.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Lists/citiesList.dart';
import 'package:travel_food/Utils/consts.dart';

import '../Models/city.dart';

class Cities extends StatefulWidget {
  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  StreamController _controller = new StreamController();
  void initState() {
    super.initState();
    getCitiesInfo();
    _controller.add(null);
  }

  Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
    getCitiesInfo();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: BoldText("Cities", 35, dayMainColor),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: SearchBar(),
            ),
            automaticallyImplyLeading: false,
          ),
          SliverFillRemaining(
            child: StreamBuilder(
                stream: _controller.stream,
                builder: (_, __) {
                  return GridView.builder(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                    itemCount: cities.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                    ),
                    dragStartBehavior: DragStartBehavior.down,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CitiesImage(cities[index].id,
                          cities[index].imageUrl, cities[index].name);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

getCitiesInfo() {
  final firestoreInstance = FirebaseFirestore.instance;
  cities = [];

  firestoreInstance.collection("Cities").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String _id = result.data()["id"];
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      cities.add(City(id: _id, imageUrl: _imageUrl, name: _name));
    });
  });
}
