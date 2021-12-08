import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/LocationsScreen.dart';
import 'package:lets_head_out/utils/cityModel.dart';

import 'TextStyles.dart';
import 'consts.dart';

class CitiesImage extends StatelessWidget {
  final City city;

  CitiesImage(this.city);

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
                        builder: (context) => Places(this.city.id)));
              },
              child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                child: Image.asset(
                  city.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 160,
            height: 160,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BoldText(
                city.name.toUpperCase(),
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
