import 'package:flutter/material.dart';
import 'package:travel_food/Prefabs/Cities.dart';
import 'package:travel_food/Prefabs/SearchBar.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Lists/citiesList.dart';
import 'package:travel_food/Utils/consts.dart';

class Cities extends StatefulWidget {
  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white70,
          title: BoldText("Cities", 35, dayTextColor),
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
          // SliverAppBar(
          //   elevation: 0.0,
          //   backgroundColor: Colors.transparent,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: SearchBar(),
          //   ),
          //   automaticallyImplyLeading: false,
          // ),
          SliverFillRemaining(
            child: GridView(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, bottom: 25.0, top: 25.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: List.generate(cities.length, (index) {
                return CitiesImage(cities[index].id, cities[index].imageUrl,
                    cities[index].name);
              }),
            ),
          )
        ],
      ),
    );
  }
}
