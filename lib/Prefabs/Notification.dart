import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/notifications.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class NotificationImage extends StatelessWidget {
  final int index;
  NotificationImage(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    notifyTitleColorer(notifications[index].title),
                    NormalText(notifications[index].message, kgreyDark, 16),
                    NormalText(notifications[index].date, kdarkBlue, 12),
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

notifyTitleColorer(String text) {
  if (text == "Warning") {
    return Text(text,
        style: TextStyle(
            fontFamily: "nunito",
            fontWeight: FontWeight.w700,
            color: Colors.red,
            fontSize: 20));
  } else {
    return Text(text,
        style: TextStyle(
            fontFamily: "nunito",
            fontWeight: FontWeight.w700,
            color: kblack,
            fontSize: 20));
  }
}
