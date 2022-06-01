import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:travel_food/Screens/Home.dart';
import 'package:travel_food/Screens/SignIn.dart';
import 'package:travel_food/Utils/Buttons.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _surnameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _repeatPasswordController = TextEditingController();

final stockProfilePictureLink =
    "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/person_110935.png?alt=media&token=2a3ad44f-ecd9-4a7e-b5a1-a32228eefeb8";

bool _obscureText = true;
bool _repeatObscureText = true;

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
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
            title: BoldText("Register", 35, dayTextColor),
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
                  SizedBox(height: 20),
                  Icon(
                    FontAwesomeIcons.route,
                    color: kdarkBlue,
                    size: 35,
                  ),
                  SizedBox(height: 10),
                  BoldText("Graduation Project 1-2", 30.0, dayMainColor),
                  NormalText("Travel & Food", dayMainColor, 30.0),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 340.0,
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: "nunito",
                            fontWeight: FontWeight.w500,
                            color: dayTextColor,
                            fontSize: 15.5),
                        keyboardType: TextInputType.name,
                        controller: _nameController,
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
                              Icons.person,
                              color: Colors.grey.shade700,
                            ),
                            hintText: "Name",
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
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 340.0,
                    child: TextFormField(
                      style: TextStyle(
                          fontFamily: "nunito",
                          fontWeight: FontWeight.w500,
                          color: dayTextColor,
                          fontSize: 15.5),
                      keyboardType: TextInputType.name,
                      controller: _surnameController,
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
                            Icons.person,
                            color: Colors.grey.shade700,
                          ),
                          hintText: "Surname",
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
                    height: 10,
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
                    height: 10,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 340.0,
                    child: TextFormField(
                      style: TextStyle(
                          fontFamily: "nunito",
                          fontWeight: FontWeight.w500,
                          color: dayTextColor,
                          fontSize: 15.5),
                      obscureText: _repeatObscureText,
                      keyboardType: TextInputType.text,
                      controller: _repeatPasswordController,
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
                              _repeatObscureText = !_repeatObscureText;
                            });
                          },
                          icon: _repeatObscureText
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
                        hintText: "Repeat Password",
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  WideButton.bold("Register", () async {
                    if (_formKey.currentState.validate()) {
                      if (_passwordController.text ==
                          _repeatPasswordController.text) {
                        _register();

                        var _uuid = Uuid().v4();

                        FirebaseFirestore.instance.collection("Users").add({
                          "id": _uuid,
                          "imageUrl": stockProfilePictureLink,
                          "name": _nameController.text,
                          "surname": _surnameController.text,
                          "e-mail": _emailController.text,
                          "password": _passwordController.text,
                        });

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setString('userEmail', _emailController.text);
                        prefs.setString('userName', _nameController.text);
                        prefs.setString('userSurname', _surnameController.text);
                        prefs.setString(
                            'userImageUrl', stockProfilePictureLink);
                        prefs.setString('userId', _uuid);
                        prefs.setString(
                            'userPassword', _passwordController.text);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Registration successful"),
                            backgroundColor: Colors.greenAccent,
                          ),
                        );

                        prefs.setBool('isLoggedIn', true);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => new Home()),
                            ModalRoute.withName("/Home"));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Passwords are different from each other, please try again"),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Registration Error, Please check fields and try again"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  }, true),
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
                          NormalText("Have an account ?", dayTextColor, 12.5),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute<bool>(
                                  fullscreenDialog: true,
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            },
                            child: BoldText.veryBold(
                                "Sign In ?", 12.5, dayTextColor, true),
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
