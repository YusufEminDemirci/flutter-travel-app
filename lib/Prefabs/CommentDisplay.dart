import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_food/Models/comment.dart';
import 'package:travel_food/Prefabs/Comments.dart';
import 'package:travel_food/Screens/Detail.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class CommentDisplay extends StatefulWidget {
  final String cityId;
  final String placeId;

  CommentDisplay(this.cityId, this.placeId);

  @override
  _CommentDisplayState createState() =>
      _CommentDisplayState(this.cityId, this.placeId);
}

class _CommentDisplayState extends State<CommentDisplay>
    with SingleTickerProviderStateMixin {
  String cityId;
  String placeId;

  _CommentDisplayState(this.cityId, this.placeId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Cities")
                        .doc(cityId)
                        .collection("Places")
                        .doc(placeId)
                        .collection("Comments")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return BoldText(
                            snapshot.data.documents.length.toString() +
                                " Reviews",
                            20.0,
                            Colors.amber);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Cities")
                        .doc(cityId)
                        .collection("Places")
                        .doc(placeId)
                        .collection("Comments")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        double rateAverage = 0;

                        snapshot.data.documents.forEach((element) {
                          rateAverage += double.parse(element["rate"]);
                        });
                        rateAverage =
                            rateAverage / snapshot.data.documents.length;

                        return Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 25.0,
                            ),
                            BoldText(rateAverage.toStringAsFixed(1), 15.0,
                                dayTextColor),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: kgreyFill,
              ),
              SizedBox(
                height: 16,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Cities")
                    .doc(cityId)
                    .collection("Places")
                    .doc(placeId)
                    .collection("Comments")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DateTime date = snapshot.data.documents[index]
                              .data()["date"]
                              .toDate();
                          String _date = date.toString();
                          String _id =
                              snapshot.data.documents[index].data()["id"];
                          String _imageUrl =
                              snapshot.data.documents[index].data()["imageUrl"];
                          String _message =
                              snapshot.data.documents[index].data()["message"];
                          String _name =
                              snapshot.data.documents[index].data()["name"];
                          String _rate =
                              snapshot.data.documents[index].data()["rate"];

                          return CommentsImage(
                            Comment(
                              date: _date,
                              id: _id,
                              imageUrl: _imageUrl,
                              message: _message,
                              name: _name,
                              rate: _rate,
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
