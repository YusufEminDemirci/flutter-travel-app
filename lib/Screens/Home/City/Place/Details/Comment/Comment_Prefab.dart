import 'package:flutter/material.dart';

import '../../../../../../Models/comment.dart';
import '../../../../../../Utils/TextStyles.dart';
import '../../../../../../Utils/consts.dart';

class Comment_Prefab extends StatelessWidget {
  final CommentModel comment;

  Comment_Prefab(
    this.comment,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(comment.imageUrl),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldText(comment.name, 16, kblack),
                      SizedBox(
                        height: 10,
                      ),
                      NormalText(comment.message, kblack, 12.0),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: dayTextColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15.0,
                            ),
                            BoldText(comment.rate, 15.0, kwhite),
                          ],
                        ),
                      ),
                      NormalText(comment.date, kgreyDark, 12.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
