import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/places.dart';
import 'package:lets_head_out/Lists/restaurants.dart';
import 'package:lets_head_out/Prefabs/Locations.dart';
import 'package:lets_head_out/Screens/Locations.dart';

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
    getPlacesInfo();
    getRestaurantsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            child: GestureDetector(
              onTap: () {
                print(places);
                print(restaurants);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new Places(this.id)));
              },
              child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BoldText(
                name.toUpperCase(),
                20,
                kwhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

getPlacesInfo() {
  final firestoreInstance = FirebaseFirestore.instance;

  firestoreInstance
      .collection("Cities")
      .doc("Gjp6AG8GF5DY0eL99Uc5")
      .collection("Places")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String _id = result.data()["id"];
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      String _location = result.data()["location"];
      String _description = result.data()["description"];
      String _rate = result.data()["rate"];
      String _type = result.data()["type"];
      String _telephone = result.data()["telephone"];
      List _whoSee = result.data()["whoSee"];
      Map _hours = result.data()["Hours"];

      for (int index = 0; index <= places.length; index++) {
        if (places.length == 0 || places[index].id != _id) {
          places.add(LocationsImage(_id, _imageUrl, _name, _location,
              _description, _rate, _type, _telephone, _whoSee, _hours));
        }
      }
    });
  });
}

getRestaurantsInfo() {
  final firestoreInstance = FirebaseFirestore.instance;

  firestoreInstance
      .collection("Cities")
      .doc("Gjp6AG8GF5DY0eL99Uc5")
      .collection("Restaurants")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      String _id = result.data()["id"];
      String _imageUrl = result.data()["imageUrl"];
      String _name = result.data()["name"];
      String _location = result.data()["location"];
      String _description = result.data()["description"];
      String _rate = result.data()["rate"];
      String _type = result.data()["type"];
      String _telephone = result.data()["telephone"];
      List _whoSee = result.data()["whoSee"];
      Map _hours = result.data()["Hours"];

      for (int index = 0; index <= restaurants.length; index++) {
        if (restaurants.length == 0 || restaurants[index].id != _id) {
          restaurants.add(LocationsImage(_id, _imageUrl, _name, _location,
              _description, _rate, _type, _telephone, _whoSee, _hours));
        }
      }
    });
  });
}
