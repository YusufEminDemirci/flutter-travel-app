import 'package:flutter/material.dart';
import 'package:lets_head_out/Lists/commentsList.dart';
import 'package:lets_head_out/Screens/Detail.dart';
import 'package:lets_head_out/Utils/TextStyles.dart';
import 'package:lets_head_out/Utils/consts.dart';

class CommentDisplay extends StatelessWidget {
  const CommentDisplay({
    Key key,
    @required this.rate,
  }) : super(key: key);

  final String rate;

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
                      BoldText("$rate Stars", 14.0, korange),
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
