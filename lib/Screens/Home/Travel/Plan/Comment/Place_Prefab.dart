import 'package:flutter/material.dart';

import '../../../../../Utils/consts.dart';

class Place_Prefab extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String rate;
  final String cityName;

  Place_Prefab(
    this.imageUrl,
    this.name,
    this.rate,
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
                    Icons.location_on,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
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
