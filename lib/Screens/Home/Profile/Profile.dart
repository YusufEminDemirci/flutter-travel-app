import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/TextStyles.dart';
import '../../../Utils/consts.dart';
import '../../../Utils/storage_service.dart';
import '../../Login_Register/Login.dart';

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
  getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("userEmail");
  }

  void initState() {
    super.initState();

    if (mounted == true) {
      // getUserInfo();
      getUserEmail();
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
                                  builder: (context) => new Login()),
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

                                    getUserEmail();

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
                                        .doc(userEmail)
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
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Users")
                                      .where("e-mail", isEqualTo: userEmail)
                                      .snapshots(),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 72,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(snapshot
                                              .data.documents[0]["imageUrl"]),
                                          radius: 70,
                                        ),
                                      );
                                    } else {
                                      return CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 72,
                                      );
                                    }
                                  },
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
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Users")
                              .where("e-mail", isEqualTo: userEmail)
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              userName = snapshot.data.documents[0]["name"];
                              userSurname =
                                  snapshot.data.documents[0]["surname"];

                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    BoldText(
                                      userName + " " + userSurname,
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
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    BoldText(
                                      " ",
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
                              );
                            }
                          },
                        ),
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
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Creator")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: kgreyDark,
                                  backgroundImage: NetworkImage(
                                    snapshot.data.documents[0]["imageUrl"],
                                  ),
                                  radius: 60,
                                ),
                                BoldText(
                                    snapshot.data.documents[0]["name"] +
                                        " " +
                                        snapshot.data.documents[0]["surname"],
                                    20,
                                    dayTextColor),
                                NormalText(snapshot.data.documents[0]["e-mail"],
                                    dayTextColor, 20),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: kgreyDark,
                                  radius: 60,
                                ),
                                BoldText("", 20, dayTextColor),
                                NormalText("", dayTextColor, 20),
                              ],
                            );
                          }
                        })
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

getUserInfo() {
  StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("Users")
        .where("e-mail", isEqualTo: userEmail)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        userName = snapshot.data()["name"];
        userSurname = snapshot.data()["surname"];
        userImageUrl = snapshot.data()["imageUrl"];

        return BoldText(
          userName + " " + userSurname,
          30,
          kwhite,
        );
      }
    },
  );
}
