import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Screens/Home.dart';
import 'package:lets_head_out/Screens/SignIn.dart';
import 'package:lets_head_out/Utils/Buttons.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

final TextEditingController _nameController = TextEditingController();
final TextEditingController _surnameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

bool _obscureText = true;

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: kwhite,
          title: BoldText("Register", 35, dayMainColor),
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
                BoldText("Graduation Project 1", 30.0, kdarkBlue),
                NormalText("Travel & Food", kdarkBlue, 30.0),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 340.0,
                    child: TextFormField(
                      style: TextStyle(
                          fontFamily: "nunito",
                          fontWeight: FontWeight.w500,
                          color: kgreyDark,
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
                        color: kgreyDark,
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
                  height: 10,
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
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                WideButton.bold("Register", () async {
                  if (_formKey.currentState.validate()) {
                    _register();

                    var _uuid = Uuid().v4();

                    FirebaseFirestore.instance.collection("Users").add({
                      "id": _uuid,
                      "imageUrl":
                          "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/WhatsApp%20Image%202021-12-17%20at%2015.51.24.jpeg?alt=media&token=d48e34d1-6978-4c9b-bd80-a7e735b7b60d",
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
                      'userImageUrl',
                      "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/WhatsApp%20Image%202021-12-17%20at%2015.51.24.jpeg?alt=media&token=d48e34d1-6978-4c9b-bd80-a7e735b7b60d",
                    );
                    prefs.setString('userId', _uuid);
                    prefs.setString('userPassword', _passwordController.text);

                    prefs.setBool('isLoggedIn', true);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => new Home()),
                        ModalRoute.withName("/Home"));
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
                        NormalText("Have an account ?", kdarkBlue, 12.5),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (context) => SignInPage(),
                            ));
                          },
                          child: BoldText.veryBold(
                              "Sign In ?", 12.5, dayMainColor, true),
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
