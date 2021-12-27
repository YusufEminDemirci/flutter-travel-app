import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Screens/Registration.dart';
import 'package:lets_head_out/Utils/Buttons.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("Sign In", 35, kwhite),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
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
                BoldText("Graduation Project 1", 30.0, kdarkBlue),
                NormalText("Travel & Food", kdarkBlue, 30.0),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 340.0,
                  child: TextFormField(
                    style: TextStyle(
                        fontFamily: "nunito",
                        fontWeight: FontWeight.w500,
                        color: kgreyDark,
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
                              print(_obscureText);
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
                  _signInWithEmailAndPassword();

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  FirebaseFirestore.instance
                      .collection("Users")
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((result) {
                      String _email = result.data()["e-mail"];
                      String _name = result.data()["name"];
                      String _surname = result.data()["surname"];
                      String _password = result.data()["password"];
                      String _imageUrl = result.data()["imageUrl"];
                      String _id = result.data()["id"];

                      if (_emailController.text == _email) {
                        prefs.setString('userEmail', _email);
                        prefs.setString('userName', _name);
                        prefs.setString('userSurname', _surname);
                        prefs.setString('userImageUrl', _imageUrl);
                        prefs.setString('userId', _id);
                        prefs.setString('userPassword', _password);

                        prefs.setBool('isLoggedIn', true);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => new Home()),
                            ModalRoute.withName("/Home"));
                      } else {
                        print("No user found");
                        //TODO: NO USER FOUND POP-UP !!!
                      }
                    });
                  });
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
                        NormalText("Don't have an account ?", kdarkBlue, 12.5),
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
                              "Register ?", 12.5, mainColor, true),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      width: 75,
                      color: kdarkBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
