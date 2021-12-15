import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/Locations.dart';

import '../Utils/TextStyles.dart';
import '../Utils/consts.dart';

class CitiesImage extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;

  CitiesImage(this.id, this.imageUrl, this.name);

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
                        builder: (context) => new Places(this.id)));
              },
              child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BoldText(
                name.toUpperCase(),
                20,
                kwhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
