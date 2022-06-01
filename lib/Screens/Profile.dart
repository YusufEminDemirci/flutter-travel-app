import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:travel_food/Lists/creators.dart';
import 'package:travel_food/Screens/EditProfile.dart';
import 'package:travel_food/Screens/Notifications.dart';
import 'package:travel_food/Screens/AboutUs.dart';
import 'package:travel_food/Screens/SignIn.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_food/Utils/storage_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String userName;
String userSurname;
String userImageUrl;
String userEmail;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();

    if (mounted == true) {
      getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: BoldText("My Profile", 35, dayTextColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: kwhite,
                size: 35,
              ),
              onPressed: () {
                Dialogs.materialDialog(
                  msg: 'Are you sure ?',
                  title: "Sign Out",
                  color: Colors.white,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      text: 'Cancel',
                      textStyle: TextStyle(color: dayTextColor),
                      iconData: Icons.cancel_outlined,
                      iconColor: dayTextColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    IconsButton(
                      color: Colors.red,
                      text: 'Sign Out',
                      textStyle: TextStyle(color: Colors.white),
                      iconData: FontAwesomeIcons.signOutAlt,
                      iconColor: Colors.white,
                      onPressed: () async {
                        if (_auth.currentUser != null) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString('userEmail', "");
                          prefs.setString('userName', "");
                          prefs.setString('userSurname', "");
                          prefs.setString('userImageUrl', "");
                          prefs.setString('userId', "");
                          prefs.setString('userPassword', "");

                          prefs.setBool('isLoggedIn', false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Logged Out"),
                              backgroundColor: Colors.greenAccent,
                            ),
                          );

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new SignInPage()),
                              ModalRoute.withName("/Home"));
                        }
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: new BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                            color: dayMainColor.withOpacity(0.6),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.75,
                        ),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: GestureDetector(
                                onTap: () async {
                                  final results =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'png'],
                                  );

                                  if (results == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("No file selected"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    userEmail = prefs.getString("userEmail");

                                    final path = results.files.single.path;
                                    final fileName = userEmail;

                                    storage
                                        .uploadFile(path, fileName)
                                        .then((value) => print("done"));
                                    String downloadUrl =
                                        await storage.getDownloadUrl(userEmail);

                                    prefs.setString("imageUrl", downloadUrl);

                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc("yBeXEnvLJ1QlTxzqh8LM")
                                        .set({
                                      "imageUrl": downloadUrl,
                                      "name": "Yusuf Emin",
                                      "password": "adminadmin",
                                      "surname": "Demirci",
                                      "e-mail": "admin@admin.com",
                                      "id":
                                          "e6d76119-910b-440a-a202-62c150b385b3",
                                    });
                                    userImageUrl = downloadUrl;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Profile picture changed. Implementation may vary depending on your internet speed"),
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 72,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: (userImageUrl != null)
                                        ? NetworkImage(userImageUrl)
                                        : AssetImage(
                                            "assets/orangeProfile.png"),
                                    radius: 70,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Align(
                                alignment: Alignment(0.25, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    color: kwhite.withOpacity(0.6),
                                  ),
                                  child: Icon(
                                    Icons.mode_edit_rounded,
                                    color: dayTextColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 200.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              (userName != null && userSurname != null)
                                  ? BoldText(
                                      userName + " " + userSurname,
                                      25.0,
                                      kwhite,
                                    )
                                  : BoldText(
                                      "Name Surname",
                                      30,
                                      kwhite,
                                    ),
                              Container(
                                height: 2,
                                width: 300,
                                color: kwhite,
                              ),
                              SizedBox(height: 25.0),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //         child: Container(
                //           height: 130,
                //           width: 130,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: kwhite,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.2),
                //                   blurRadius: 10,
                //                   spreadRadius: 5,
                //                 ),
                //               ]),
                //           child: profileItem(
                //               FontAwesomeIcons.edit, "Edit Profile"),
                //         ),
                //         onTap: () async {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => new EditProfile()));
                //         }),
                //   ],
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: kgreyDark,
                          backgroundImage: AssetImage("assets/kku-logo.jpeg"),
                          radius: 60,
                        ),
                        BoldText("KIRIKKALE ÜNİVERSİTESİ", 20, dayTextColor),
                        NormalText("2021-2022", dayTextColor, 20),
                        NormalText("Bitirme Projesi 1-2", dayTextColor, 20),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: kgreyDark,
                          backgroundImage: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/projectx-b164c.appspot.com/o/WhatsApp%20Image%202021-12-17%20at%2015.51.24.jpeg?alt=media&token=d48e34d1-6978-4c9b-bd80-a7e735b7b60d",
                          ),
                          radius: 60,
                        ),
                        BoldText(
                            creators[0]["name"] + " " + creators[0]["surname"],
                            20,
                            dayTextColor),
                        NormalText(creators[0]["e-mail"], dayTextColor, 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget profileItem(IconData icon, String text) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         Icon(
  //           icon,
  //           color: dayTextColor,
  //           size: 35,
  //         ),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontSize: 20,
  //             color: dayTextColor,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  userName = prefs.getString('userName');
  userSurname = prefs.getString('userSurname');
  userImageUrl = prefs.getString('userImageUrl');
}
