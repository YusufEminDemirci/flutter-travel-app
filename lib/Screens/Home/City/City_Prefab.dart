import 'package:flutter/material.dart';
import 'package:travel_food/Screens/Home/City/Place/Place.dart';

import '../../../Utils/TextStyles.dart';
import '../../../Utils/consts.dart';

class City_Prefab extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;

  City_Prefab(this.id, this.imageUrl, this.name);

  @override
  _City_PrefabState createState() =>
      _City_PrefabState(this.id, this.imageUrl, this.name);
}

class _City_PrefabState extends State<City_Prefab> {
  String id;
  String imageUrl;
  String name;

  _City_PrefabState(this.id, this.imageUrl, this.name);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          // fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.4,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new Places(this.id, this.name),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: BoldText(
                  name.toUpperCase(),
                  22,
                  dayTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
