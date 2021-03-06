import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/consts.dart';
import '../Login_Register/Login.dart';
import 'City/City.dart';
import 'Profile/Profile.dart';
import 'Travel/Travel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _cIndex = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('isLoggedIn') ?? false;

    if (!status) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new Login()),
          ModalRoute.withName("/Home"));
    }
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: BottomNavyBar(
            selectedIndex: _cIndex,
            showElevation: true,
            backgroundColor: kwhite,
            items: [
              BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.searchLocation),
                activeColor: dayMainColor,
                inactiveColor: dayTextColor,
                title: Text(
                  "Cities",
                  style: TextStyle(fontFamily: "Brandon"),
                ),
              ),
              BottomNavyBarItem(
                icon: Icon(
                  FontAwesomeIcons.route,
                ),
                title: Text(
                  "My Plan",
                  style: TextStyle(fontFamily: "Brandon"),
                ),
                activeColor: dayMainColor,
                inactiveColor: kgreyDark,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  "Profile",
                  style: TextStyle(fontFamily: "Brandon"),
                ),
                activeColor: dayMainColor,
                inactiveColor: kgreyDark,
              )
            ],
            onItemSelected: (index) {
              _incrementTab(index);
            },
          ),
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _cIndex = index);
          },
          children: <Widget>[
            City(),
            Travel(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
