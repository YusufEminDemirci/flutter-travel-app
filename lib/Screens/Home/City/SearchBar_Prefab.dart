import 'package:flutter/material.dart';

import '../../../Utils/forms.dart';

class SearchBar_Prefab extends StatefulWidget {
  final String placeholder;

  const SearchBar_Prefab({Key key, this.placeholder}) : super(key: key);

  @override
  _SearchBar_PrefabState createState() =>
      new _SearchBar_PrefabState(this.placeholder);
}

class _SearchBar_PrefabState extends State<SearchBar_Prefab> {
  String placeholder;

  _SearchBar_PrefabState(this.placeholder);

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
            child: NameForm(Icons.search, placeholder),
          ),
        ),
      ],
    );
  }
}
