import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/consts.dart';
import 'Details/Detail.dart';

class Place_Prefab extends StatelessWidget {
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

  Place_Prefab(
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
                        builder: (context) => new Detail(
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
                      Icons.location_city_rounded,
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
      ),
    );
  }
}
