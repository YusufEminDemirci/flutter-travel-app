import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/placesList.dart';
import 'package:lets_head_out/utils/PlacesImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/utils/imageContainer.dart';

class Places extends StatefulWidget {
  final String city;

  Places(this.city);

  @override
  _PlacesState createState() => _PlacesState(this.city);
}

class _PlacesState extends State<Places> {
  final String city;

  _PlacesState(this.city);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImageContainer(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText("Places", 20.0, kblack),
                    ),
                  ),
                  Column(
                    children: checkPlaces(city),
                  ),
                  SizedBox(
                    height: 28,
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

checkPlaces(String city) {
  List<PlacesImage> getPlaces = [];
  for (int index = 0; index < places.length; index++) {
    if (places[index]["location"].toLowerCase() == city.toLowerCase()) {
      getPlaces.add(PlacesImage(
        places[index]["imageUrl"],
        places[index]["name"],
        places[index]["description"],
        places[index]["location"],
        places[index]["rate"],
      ));
    }
  }
  return getPlaces;
}
