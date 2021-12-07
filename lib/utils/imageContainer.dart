import 'package:flutter/material.dart';

import 'TextStyles.dart';
import 'consts.dart';
import 'forms.dart';

class ImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: 150.0,
      width: 420.0,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 30.0, bottom: 50.0, left: 20, right: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BoldText("What are you, Looking for?", 29.0, kblack),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: NormalForm(Icons.search, "Where do you want to go"),
            ),
          ),
        ],
      ),
    );
  }
}
