import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../Utils/consts.dart';

class Place_Prefab extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String cityId;
  final String cityName;

  Place_Prefab(
    this.id,
    this.imageUrl,
    this.name,
    this.cityId,
    this.cityName,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: MediaQuery.of(context).size.width * 0.29,
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
                    Icons.location_city_rounded,
                    color: kblack,
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
                  width: 15,
                ),
                SizedBox(
                  child: Container(
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: dayMainColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Cities")
                          .doc(cityId)
                          .collection("Places")
                          .doc(id)
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16.0,
                              ),
                              Text(
                                rateAverage.toStringAsFixed(1),
                                style: TextStyle(
                                  color: kwhite,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
