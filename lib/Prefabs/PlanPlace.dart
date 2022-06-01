import 'package:flutter/material.dart';
import 'package:travel_food/Lists/selectedPlaces.dart';
import 'package:travel_food/Lists/selectedRestaurants.dart';
import 'package:travel_food/Screens/Detail.dart';
import 'package:travel_food/Utils/consts.dart';

class PlanPlace extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final String rate;
  final String type;
  final String telephone;
  final String latitude;
  final String longitude;
  final List whoSee;
  final Map hours;
  final String cityName;
  final String cityId;

  PlanPlace(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.latitude,
    this.longitude,
    this.whoSee,
    this.hours,
    this.cityName,
    this.cityId,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.4,
                child: ClipRRect(
                  borderRadius: new BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0)),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 110.0),
              child: Text(
                name,
                style: TextStyle(
                  color: kwhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 145.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    child: Icon(
                      Icons.location_on,
                      color: dayTextColor,
                      size: 17.0,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      cityName,
                      style: TextStyle(
                        color: dayTextColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    width: 50,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    child: Container(
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: dayMainColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          Text(
                            rate.toString(),
                            style: TextStyle(
                              color: kwhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPlaces.length > 0 ||
                      selectedRestaurants.length > 0) {
                    for (int index = 0;
                        index < selectedPlaces.length;
                        index++) {
                      if (id == selectedPlaces[index].id) {
                        selectedPlaces.remove(selectedPlaces[index]);
                      }
                    }
                    for (int index = 0;
                        index < selectedRestaurants.length;
                        index++) {
                      if (id == selectedRestaurants[index].id) {
                        selectedRestaurants.remove(selectedRestaurants[index]);
                      }
                    }
                  }
                  setState() {}
                },
                child: Icon(Icons.delete),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shadowColor: dayTextColor,
                  elevation: 4.0,
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
                  minimumSize: Size(30, 30),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
