import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_food/Lists/places.dart';
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
    getPlacesInfo(id, name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new Places(this.id, this.name)),
                );
              },
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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: BoldText(
                  name.toUpperCase(),
                  22,
                  kblack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

getPlacesInfo(String cityId, String cityName) async {
  final firestoreInstance = FirebaseFirestore.instance;

  firestoreInstance
      .collection("Cities")
      .doc(cityId)
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
        if ((places.length == 0 || places[index].id != _id) &&
            _type == "place") {
          places.add(LocationsImage(
              _id,
              _imageUrl,
              _name,
              _location,
              _description,
              _rate,
              _type,
              _telephone,
              _whoSee,
              _hours,
              cityName));
        }
      }
    });
  });
}
