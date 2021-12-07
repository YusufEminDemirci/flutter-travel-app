import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/ContentSelectionScreen.dart';

import 'TextStyles.dart';
import 'consts.dart';

class CitiesImage extends StatelessWidget {
  final String imgUrl;
  final String city;

  CitiesImage(this.imgUrl, this.city);

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
                        builder: (context) =>
                            ContentSelectionScreen(this.city)));
              },
              child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                child: Image.asset(
                  imgUrl,
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
                city,
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
