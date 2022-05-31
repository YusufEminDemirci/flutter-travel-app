import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_food/Screens/Profile.dart';
import 'package:travel_food/Utils/Buttons.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => new _EditProfile();
}

final TextEditingController _passwordController = TextEditingController();
final TextEditingController _passwordCheckController = TextEditingController();
bool _obscureText = true;
bool _obscureCheckText = true;

class _EditProfile extends State<EditProfile> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: Colors.transparent,
          title: BoldText("Edit Profile", 35, dayMainColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 340.0,
              child: TextFormField(
                style: TextStyle(
                    fontFamily: "nunito",
                    fontWeight: FontWeight.w500,
                    color: kgreyDark,
                    fontSize: 15.5),
                obscureText: _obscureText,
                keyboardType: TextInputType.text,
                controller: _passwordController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This Field Cannot Be Left Blank !';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey.shade700,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? Icon(
                            FontAwesomeIcons.eye,
                            color: Colors.grey.shade700,
                          )
                        : Icon(
                            FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade700,
                          ),
                    iconSize: 20,
                  ),
                  hintText: "New Password",
                  hintStyle: TextStyle(
                      fontFamily: "nunito",
                      fontWeight: FontWeight.w500,
                      color: kgreyDark,
                      fontSize: 15.5),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusColor: Colors.grey.shade700,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 340.0,
              child: TextFormField(
                style: TextStyle(
                    fontFamily: "nunito",
                    fontWeight: FontWeight.w500,
                    color: kgreyDark,
                    fontSize: 15.5),
                obscureText: _obscureCheckText,
                keyboardType: TextInputType.text,
                controller: _passwordCheckController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This Field Cannot Be Left Blank !';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey.shade700,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureCheckText = !_obscureCheckText;
                      });
                    },
                    icon: _obscureCheckText
                        ? Icon(
                            FontAwesomeIcons.eye,
                            color: Colors.grey.shade700,
                          )
                        : Icon(
                            FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade700,
                          ),
                    iconSize: 20,
                  ),
                  hintText: "New Password (Control)",
                  hintStyle: TextStyle(
                      fontFamily: "nunito",
                      fontWeight: FontWeight.w500,
                      color: kgreyDark,
                      fontSize: 15.5),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusColor: Colors.grey.shade700,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            WideButton.bold("Save", () async {
              // SharedPreferences prefs = await SharedPreferences.getInstance();

              // FirebaseFirestore.instance
              //     .collection("Users")
              //     .get()
              //     .then((querySnapshot) {
              //   querySnapshot.docs.forEach((result) {
              //     String _email = result.data()["e-mail"];
              //     String _password = result.data()["password"];

              //     String _name = result.data()["name"];
              //     String _surname = result.data()["surname"];
              //     String _imageUrl = result.data()["imageUrl"];
              //     String _id = result.data()["id"];

              //     prefs.setString('userEmail', _email);
              //     prefs.setString('userName', _name);
              //     prefs.setString('userSurname', _surname);
              //     prefs.setString('userImageUrl', _imageUrl);
              //     prefs.setString('userId', _id);
              //     prefs.setString('userPassword', _password);

              //     prefs.setBool('isLoggedIn', true);

              //     Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(builder: (context) => new Profile()),
              //         ModalRoute.withName("/Home"));
              //   });
              // });
              // if (_passwordController.text == _passwordCheckController.text) {
              //   prefs.setString('userPassword', _passwordController.text);
              // }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => new Profile()),
                  ModalRoute.withName("/Home"));
            }, true),
          ],
        ),
      ),
    );
  }
}
