import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_food/Utils/consts.dart';

class PlanPlace extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String rate;

  PlanPlace(
    this.id,
    this.imageUrl,
    this.name,
    this.rate,
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
              padding: const EdgeInsets.only(left: 10.0, top: 145.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    child: Icon(
                      Icons.security_rounded,
                      color: dayTextColor,
                      size: 17.0,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "",
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
            Positioned(
              top: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String userMail = prefs.getString("userEmail");

                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(userMail)
                      .collection('selected')
                      .doc(id)
                      .delete();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(name + " removed"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                },
                child: Icon(Icons.delete),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shadowColor: dayTextColor,
                  elevation: 4.0,
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
                  minimumSize: Size(30, 30),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
