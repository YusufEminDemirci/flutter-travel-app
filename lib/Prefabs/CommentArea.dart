import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_food/Prefabs/CommentPlace.dart';
import 'package:travel_food/Utils/consts.dart';

class CommentArea extends StatelessWidget {
  final String id;
  String imageUrl;
  final String name;
  final String location;
  final String description;
  final String rate;
  final String type;
  final String telephone;
  final List whoSee;
  final Map hours;
  final String cityName;
  final String cityId;

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
      this.cityName,
      this.cityId);

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double starRating = 0.0;

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
              CommentPlace(
                id,
                imageUrl,
                name,
                location,
                description,
                rate,
                type,
                telephone,
                whoSee,
                hours,
                cityName,
                cityId,
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
                        padding: const EdgeInsets.only(top: 15.0),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 0.5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 35.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            starRating = rating;
                          },
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
                                  color: dayTextColor,
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
                              onTap: () async {
                                if (myController != null &&
                                    myController.text.length > 6) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  String uName = prefs.getString("userName");
                                  String uSurname =
                                      prefs.getString("userSurname");

                                  await FirebaseFirestore.instance
                                      .collection("Users")
                                      .get()
                                      .then((querySnapshot) {
                                    querySnapshot.docs.forEach((result) {
                                      String fullName = result.data()["name"] +
                                          " " +
                                          result.data()["surname"];

                                      if (fullName == uName + " " + uSurname) {
                                        imageUrl = result.data()["imageUrl"];
                                      }
                                    });
                                  });

                                  FirebaseFirestore.instance
                                      .collection("Cities")
                                      .doc(location)
                                      .collection("Places")
                                      .doc(id)
                                      .collection("Comments")
                                      .add({
                                    "date": DateTime.now(),
                                    "id": id,
                                    "imageUrl": imageUrl,
                                    "message": myController.text,
                                    "name": uName + " " + uSurname,
                                    "rate": starRating.toString(),
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
