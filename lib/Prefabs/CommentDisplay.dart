import 'package:flutter/material.dart';
import 'package:travel_food/Lists/commentsList.dart';
import 'package:travel_food/Screens/Detail.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class CommentDisplay extends StatelessWidget {
  const CommentDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BoldText(
                      comments.length.toString() + " Reviews", 20.0, kblack),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: dayMainColor,
                        size: 25.0,
                      ),
                      BoldText("3.5 Stars", 14.0, korange),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: kgreyFill,
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return comments[index];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
