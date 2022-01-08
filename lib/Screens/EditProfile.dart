import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => new _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: Colors.transparent,
          title: BoldText("Edit Profile", 35, dayMainColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.check,
                color: kwhite,
              ),
              onPressed: () {
                //TODO: SAVE EDITED PROFILE !!!
              },
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        //TODO: EDIT PROFILE !!!
        child: Text(
          "Coming soon...",
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
