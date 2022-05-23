import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:travel_food/Models/comment.dart';

import '../Utils/consts.dart';

class CommentsImage extends StatelessWidget {
  final Comment comment;

  CommentsImage(
    this.comment,
  );

  void initState() {
    getProfileImages();
  }

  getProfileImages() {
    FirebaseFirestore.instance.collection("Users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        String fullName =
            result.data()["name"] + " " + result.data()["surname"];

        if (fullName == comment.name) {
          comment.imageUrl = result.data()["imageUrl"];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(comment.imageUrl),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            BoldText(comment.name, 16, kblack)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Container(
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
                    size: 15.0,
                  ),
                  BoldText(comment.rate, 15.0, kwhite),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            NormalText(comment.date, kgreyDark, 12.0)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        NormalText(comment.message, kblack, 12.0),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
