import 'package:flutter/material.dart';
import 'package:lets_head_out/Prefabs/Cities.dart';
import 'package:lets_head_out/Prefabs/SearchBar.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Lists/citiesList.dart';
import 'package:lets_head_out/Utils/consts.dart';

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
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: BoldText("Cities", 35, mainColor),
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
            child: GridView(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 16.0, bottom: 16.0, top: 25.0),
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
