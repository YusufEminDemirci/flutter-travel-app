import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Utils/consts.dart';

class CommentArea extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final String rate;
  final String type;
  final String telephone;
  final List whoSee;
  final Map hours;
  final String cityId;
  final String cityName;

  CommentArea(
      this.id,
      this.imageUrl,
      this.name,
      this.location,
      this.description,
      this.rate,
      this.type,
      this.telephone,
      this.whoSee,
      this.hours,
      this.cityId,
      this.cityName);

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: 375,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 85.0,
                      ),
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
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 120.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            child: Icon(
                              Icons.location_on,
                              color: kblack,
                              size: 17.0,
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              cityName,
                              style: TextStyle(
                                color: kblack,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            child: Container(
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: korange,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: kwhite,
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
              SizedBox(
                width: 2,
              ),
              Container(
                width: 208,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.star, color: korange),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 85,
                            child: TextField(
                              controller: myController,
                              minLines: 1,
                              maxLines: 5,
                              maxLength: 100,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Write a comment'),
                              style: TextStyle(
                                  fontFamily: "nunito",
                                  fontWeight: FontWeight.w500,
                                  color: kgreyDark,
                                  fontSize: 12.5),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 30.0),
                            child: GestureDetector(
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.black54,
                              ),
                              onTap: () {
                                if (type == "place") {
                                  FirebaseFirestore.instance
                                      .collection("Cities")
                                      .doc("Gjp6AG8GF5DY0eL99Uc5")
                                      .collection("Places")
                                      .doc("MZUWZdKp6Rtzr3QFQIps")
                                      .collection("Comments")
                                      .add({
                                    "date": DateTime.now(),
                                    "id": id,
                                    "imageUrl": imageUrl,
                                    "message": myController.text,
                                    "name": "Yusuf Emin Demirci",
                                    "rate": "5",
                                  });
                                } else if (type == "restaurant") {
                                  FirebaseFirestore.instance
                                      .collection("Cities")
                                      .doc("Gjp6AG8GF5DY0eL99Uc5")
                                      .collection("Restaurants")
                                      .doc("MZUWZdKp6Rtzr3QFQIps")
                                      .collection("Comments")
                                      .add({
                                    "date": DateTime.now(),
                                    "id": id,
                                    "imageUrl": imageUrl,
                                    "message": myController.text,
                                    "name": "Yusuf Emin Demirci",
                                    "rate": "5",
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
