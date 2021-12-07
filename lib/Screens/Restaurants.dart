import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/restaurantsList.dart';
import 'package:lets_head_out/utils/PlacesImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/utils/imageContainer.dart';

class Restaurants extends StatefulWidget {
  final String city;

  Restaurants(this.city);

  @override
  _RestaurantsState createState() => _RestaurantsState(this.city);
}

class _RestaurantsState extends State<Restaurants> {
  final String city;

  _RestaurantsState(this.city);

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
                      child: BoldText("Restaurants", 20.0, kblack),
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
  List<PlacesImage> getRestaurants = [];
  for (int index = 0; index < restaurants.length; index++) {
    if (restaurants[index]["location"].toLowerCase() == city.toLowerCase()) {
      getRestaurants.add(PlacesImage(
        restaurants[index]["imageUrl"],
        restaurants[index]["name"],
        restaurants[index]["description"],
        restaurants[index]["location"],
        restaurants[index]["rate"],
      ));
    }
  }
  return getRestaurants;
}
