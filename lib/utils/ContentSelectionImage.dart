import 'package:flutter/material.dart';

import 'TextStyles.dart';
import 'consts.dart';

class ContentSelectionImage extends StatelessWidget {
  final String imgUrl;
  final String city;

  ContentSelectionImage(this.imgUrl, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 520,
      child: Stack(
        children: <Widget>[
          Container(
            width: 185,
            height: 520,
            child: ClipRRect(
              borderRadius: new BorderRadius.all(Radius.circular(15.0)),
              child: Image.asset(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 185,
            height: 500,
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
