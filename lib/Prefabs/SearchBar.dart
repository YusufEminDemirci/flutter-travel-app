import 'package:flutter/material.dart';
import '../Utils/forms.dart';

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
            child:
                NormalForm(Icons.search, "Which city would you like to visit?"),
          ),
        ),
      ],
    );
  }
}
