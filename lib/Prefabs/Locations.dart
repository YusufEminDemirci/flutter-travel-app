import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/Detail.dart';
import 'package:lets_head_out/Utils/consts.dart';

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
  final String cityName;

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
    this.hours,
    this.cityName,
  );

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
                              this.hours,
                              this.cityName,
                            )));
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
            padding: const EdgeInsets.only(left: 8.0, top: 152.0),
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
                  width: 50,
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
    );
  }
}
