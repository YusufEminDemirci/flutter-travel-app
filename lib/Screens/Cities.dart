import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Prefabs/Cities.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: BoldText("Cities", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 16.0, bottom: 16.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 30.0,
                      right: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText(
                          "Which city would you like to visit?", 21.0, kblack),
                    ),
                  ),
                  Column(
                    children: getCities(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getCities() {
  List<Widget> cityList = [];
  for (int index = 0; index < cities.length; index += 2) {
    cityList.add(Row(children: [
      CitiesImage(cities[index].id, cities[index].imageUrl, cities[index].name),
      SizedBox(width: 20.0),
      CitiesImage(cities[index + 1].id, cities[index + 1].imageUrl,
          cities[index + 1].name),
    ]));
    cityList.add(SizedBox(height: 20.0));
  }
  return cityList;
}
