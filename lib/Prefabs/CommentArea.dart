import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Utils/consts.dart';

class CommentArea extends StatelessWidget {
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
      this.hours);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: 375,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber.shade50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
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
              SizedBox(
                width: 2,
              ),
              Container(
                width: 223,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.solidStar, color: korange),
                            Icon(FontAwesomeIcons.star, color: korange),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 85,
                            child: TextField(
                              minLines: 1,
                              maxLines: 5,
                              maxLength: 100,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Write a comment'),
                              style: TextStyle(
                                  fontFamily: "nunito",
                                  fontWeight: FontWeight.w500,
                                  color: kgreyDark,
                                  fontSize: 12.5),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.5, bottom: 25.0),
                            child: GestureDetector(
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.black54,
                              ),
                              onTap: () {
                                //TODO: ADD COMMENT
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
