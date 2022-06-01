import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:travel_food/Screens/Registration.dart';
import 'package:travel_food/Utils/Buttons.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

bool _obscureText = true;

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kwhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: kwhite,
            title: BoldText("Sign In", 35, dayTextColor),
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Icon(
                    FontAwesomeIcons.route,
                    color: kdarkBlue,
                    size: 35,
                  ),
                  SizedBox(height: 10),
                  BoldText("Graduation Project 1", 30.0, dayMainColor),
                  NormalText("Travel & Food", dayMainColor, 30.0),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 340.0,
                    child: TextFormField(
                      style: TextStyle(
                          fontFamily: "nunito",
                          fontWeight: FontWeight.w500,
                          color: dayTextColor,
                          fontSize: 15.5),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
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
                            Icons.email,
                            color: Colors.grey.shade700,
                          ),
                          hintText: "E-mail",
                          hintStyle: TextStyle(
                              fontFamily: "nunito",
                              fontWeight: FontWeight.w500,
                              color: kgreyDark,
                              fontSize: 15.5),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusColor: Colors.grey.shade700,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          )),
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
                          color: dayTextColor,
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
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.grey.shade700,
                                  )
                                : Icon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.grey.shade700,
                                  ),
                            iconSize: 20,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontFamily: "nunito",
                              fontWeight: FontWeight.w500,
                              color: dayTextColor,
                              fontSize: 15.5),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusColor: Colors.grey.shade700,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: BoldText.veryBold(
                          "Forgot your Password ?", 12.5, kdarkBlue, true),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  WideButton.bold("SIGN IN", () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    bool success = false;

                    FirebaseFirestore.instance
                        .collection("Users")
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        String _email = result.data()["e-mail"];
                        String _password = result.data()["password"];

                        _signInWithEmailAndPassword();

                        if (_emailController.text == _email &&
                            _passwordController.text == _password) {
                          String _name = result.data()["name"];
                          String _surname = result.data()["surname"];
                          String _imageUrl = result.data()["imageUrl"];
                          String _id = result.data()["id"];

                          prefs.setString('userEmail', _email);
                          prefs.setString('userName', _name);
                          prefs.setString('userSurname', _surname);
                          prefs.setString('userImageUrl', _imageUrl);
                          prefs.setString('userId', _id);
                          prefs.setString('userPassword', _password);

                          prefs.setBool('isLoggedIn', true);

                          success = true;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Logged In"),
                              backgroundColor: Colors.greenAccent,
                            ),
                          );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => new Home()),
                            ModalRoute.withName("/Home"),
                          );

                          _emailController.text = "";
                          _passwordController.text = "";
                        } else {
                          success = false;
                        }
                      });
                    });

                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "The information you entered is incorrect, please check your information"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  }, true),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 2,
                        width: 75,
                        color: kdarkBlue,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NormalText(
                              "Don't have an account ?", dayTextColor, 12.5),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(CupertinoPageRoute<bool>(
                                fullscreenDialog: true,
                                builder: (context) => RegistrationScreen(),
                              ));
                            },
                            child: BoldText.veryBold(
                                "Register ?", 12.5, dayTextColor, true),
                          ),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: 75,
                        color: dayTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
