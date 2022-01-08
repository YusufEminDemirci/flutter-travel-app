import 'package:flutter/material.dart';
import 'package:travel_food/Utils/forms.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Align(
            alignment: Alignment.center,
            child: NameForm(
                Icons.search, "Coding of this search bar will be added soon"),
          ),
        ),
      ],
    );
  }
}
