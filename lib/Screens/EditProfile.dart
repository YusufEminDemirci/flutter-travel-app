import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

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
          leading: BackButton(color: mainColor),
          backgroundColor: Colors.transparent,
          title: BoldText("Edit Profile", 35, mainColor),
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
          //TODO: EDIT PROFILE !!!
          
          ),
    );
  }
}
