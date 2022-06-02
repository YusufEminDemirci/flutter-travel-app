import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Utils/consts.dart';
import 'Place_Prefab.dart';

class Comment_Prefab extends StatelessWidget {
  final String id;
  String imageUrl;
  final String name;
  final String location;
  final String cityId;
  final String cityName;

  Comment_Prefab(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.cityId,
    this.cityName,
  );

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
              Place_Prefab(
                id,
                imageUrl,
                name,
                cityId,
                cityName,
              ),
              SizedBox(
                width: 2,
              ),
              Container(
                width: 200,
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
                                const EdgeInsets.only(left: 5, bottom: 30.0),
                            child: GestureDetector(
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.black54,
                              ),
                              onTap: () async {
                                if (myController != null) {
                                  if (myController.text.length > 6) {
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
                                        String fullName =
                                            result.data()["name"] +
                                                " " +
                                                result.data()["surname"];

                                        if (fullName ==
                                            uName + " " + uSurname) {
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

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Comment successfully made"),
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Comment cannot be less than 6 characters"),
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Comment cannot be left blank"),
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                  );
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
