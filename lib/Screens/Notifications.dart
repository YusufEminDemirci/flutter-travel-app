import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/notifications.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: BoldText("Notifications", 20, kwhite),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
            },
            background: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
            child: notification(index),
          );
        },
      ),
    );
  }

  notification(int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.amber.shade50,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 25,
                    child: CircleAvatar(
                      backgroundColor: kwhite,
                      radius: 23,
                      child: Icon(
                        notifications[index].icon,
                        size: 35.0,
                        color: kblack,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BoldText(notifications[index].title, 20.0, kblack),
                      NormalText(notifications[index].message, kgreyDark, 16),
                      NormalText(notifications[index].date, kdarkBlue, 12),
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
