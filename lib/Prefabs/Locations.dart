import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/Detail.dart';

import '../Utils/consts.dart';

class LocationsImage extends StatelessWidget {
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

  LocationsImage(
      this.id,
      this.imageUrl,
      this.name,
      this.location,
      this.description,
      this.rate,
      this.type,
      this.telephone,
      this.whoSee,
      this.hours);

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new DetailScreen(
                            this.id,
                            this.imageUrl,
                            this.name,
                            this.location,
                            this.description,
                            this.rate,
                            this.type,
                            this.telephone,
                            this.whoSee,
                            this.hours)));
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
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 100.0),
            child: Text(
              name,
              style: TextStyle(
                color: kwhite,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 120.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Icon(
                    Icons.location_on,
                    color: kwhite,
                    size: 16.0,
                  ),
                ),
                SizedBox(
                  child: Text(
                    location,
                    style: TextStyle(
                      color: kwhite,
                      fontSize: 13.0,
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
                          size: 15.0,
                        ),
                        Text(
                          rate.toString(),
                          style: TextStyle(
                            color: kwhite,
                            fontSize: 15.0,
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
    );
  }
}
