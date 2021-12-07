import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/DetailScreen.dart';

import 'consts.dart';

class PlacesImage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String description;
  final String rate;

  PlacesImage(
      this.imageUrl, this.name, this.description, this.location, this.rate);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: 350.0,
        height: 175.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new OverViewPage(
                                    this.imageUrl,
                                    this.name,
                                    this.location,
                                    this.description,
                                    this.rate)));
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.fitHeight,
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
                            child: Positioned(
                              child: Icon(
                                Icons.location_on,
                                color: kwhite,
                                size: 16.0,
                              ),
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
                Container(
                    child: Expanded(
                  child: Column(
                    children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10.0,
                          ),
                          height: 30.0,
                          width: 200.0,
                          child: Text(
                            "DESCRIPTION",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 20.0,
                          ),
                          width: 150.0,
                          child: Text(
                            description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
