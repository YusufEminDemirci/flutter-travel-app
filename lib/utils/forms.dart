import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_food/Utils/consts.dart';

class PasswordForm extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _surnameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _FormsState extends State<PasswordForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: "nunito",
          fontWeight: FontWeight.w500,
          color: kgreyDark,
          fontSize: 15.5),
      obscureText: _obscureText,
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
          hintText: "Password",
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
          )),
    );
  }
}

class NameForm extends StatelessWidget {
  final IconData icon;
  final String hint;

  NameForm(this.icon, this.hint);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: "nunito",
          fontWeight: FontWeight.w500,
          color: kgreyDark,
          fontSize: 15.5),
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
            icon,
            color: Colors.grey.shade700,
          ),
          hintText: hint,
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
          )),
    );
  }
}

class SurnameForm extends StatelessWidget {
  final IconData icon;
  final String hint;

  SurnameForm(this.icon, this.hint);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: "nunito",
          fontWeight: FontWeight.w500,
          color: kgreyDark,
          fontSize: 15.5),
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
            icon,
            color: Colors.grey.shade700,
          ),
          hintText: hint,
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
          )),
    );
  }
}

class EmailForm extends StatelessWidget {
  final IconData icon;
  final String hint;

  EmailForm(this.icon, this.hint);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: "nunito",
          fontWeight: FontWeight.w500,
          color: kgreyDark,
          fontSize: 15.5),
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
            icon,
            color: Colors.grey.shade700,
          ),
          hintText: hint,
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
          )),
    );
  }
}
