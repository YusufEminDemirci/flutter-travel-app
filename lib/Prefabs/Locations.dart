import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_food/Lists/places.dart';
import 'package:travel_food/Lists/restaurants.dart';
import 'package:travel_food/Screens/Detail.dart';
import 'package:travel_food/Utils/consts.dart';

class LocationsImage extends StatelessWidget {
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

  LocationsImage(
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
  void initState() {
    getPlacesInfo(cityId, cityName);
  }

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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new DetailScreen(
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
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
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
          ],
        ),
      ),
    );
  }
}

getPlacesInfo(String cityId, String cityName) async {
  final firestoreInstance = FirebaseFirestore.instance;
  places = [];
  restaurants = [];
  firestoreInstance
      .collection("Cities")
      .doc(cityId)
      .collection("Places")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) async {
      String id = result.data()["id"];
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      String _location = result.data()["location"];
      String _description = result.data()["description"];
      String rate = "0.0";
      String _type = result.data()["type"];
      String _telephone = result.data()["telephone"];
      String _latitude = result.data()["latitude"];
      String _longitude = result.data()["longitude"];
      List _whoSee = [];
      Map _hours = result.data()["Hours"];

      List rateList = [];

      await firestoreInstance
          .collection("Cities")
          .doc(cityId)
          .collection("Places")
          .doc(id)
          .collection("Comments")
          .get()
          .then((querySnapshot) {
        final commentList = querySnapshot.docs;
        rateList = [];
        for (var comment in commentList) {
          String rate = comment.data()["rate"];
          rateList.add(rate);
        }
        double rateAverage = 0;
        for (var rate in rateList) {
          rateAverage += double.parse(rate);
        }
        rateAverage = rateAverage / rateList.length;
        if (rateAverage.isNaN) {
          rate = "0.0";
        } else {
          rate = rateAverage.toStringAsFixed(1);
        }
      });
      print(rate);

      if (_type == "place" && _location == cityId) {
        places.add(
          LocationsImage(
            id,
            _imageUrl,
            _name,
            _location,
            _description,
            rate,
            _type,
            _telephone,
            _latitude,
            _longitude,
            _whoSee,
            _hours,
            cityName,
            cityId,
          ),
        );
      }
      if (_type == "restaurant" && _location == cityId) {
        restaurants.add(
          LocationsImage(
            id,
            _imageUrl,
            _name,
            _location,
            _description,
            rate,
            _type,
            _telephone,
            _latitude,
            _longitude,
            _whoSee,
            _hours,
            cityName,
            cityId,
          ),
        );
      }
    });
  });
}
