import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_food/Lists/places.dart';
import 'package:travel_food/Lists/restaurants.dart';
import 'package:travel_food/Prefabs/Locations.dart';
import 'package:travel_food/Screens/Locations.dart';

import '../Utils/TextStyles.dart';
import '../Utils/consts.dart';

class CitiesImage extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;

  CitiesImage(this.id, this.imageUrl, this.name);

  @override
  _CitiesImageState createState() =>
      _CitiesImageState(this.id, this.imageUrl, this.name);
}

class _CitiesImageState extends State<CitiesImage> {
  String id;
  String imageUrl;
  String name;

  _CitiesImageState(this.id, this.imageUrl, this.name);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          // fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      getPlacesInfo(id, name);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new Places(this.id, this.name),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: BoldText(
                  name.toUpperCase(),
                  22,
                  dayTextColor,
                ),
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
      double rateAverage = 0;

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
        for (var rate in rateList) {
          rateAverage += double.parse(rate);
        }
        rateAverage = rateAverage / rateList.length;
        if (rateAverage.isNaN) {
          return rate = "0.0";
        } else {
          return rate = rateAverage.toStringAsFixed(1);
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
