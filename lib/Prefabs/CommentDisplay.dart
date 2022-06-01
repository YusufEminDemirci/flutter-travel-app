import 'package:flutter/material.dart';
import 'package:travel_food/Lists/commentsList.dart';
import 'package:travel_food/Screens/Detail.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class CommentDisplay extends StatelessWidget {
  double rateAverage = 0;

  getAverage() {
    comments.forEach((element) {
      rateAverage += double.parse(element.comment.rate);
    });
    rateAverage = rateAverage / comments.length;
    if (rateAverage.isNaN) {
      return "Derecelendirme Yok";
    } else {
      return rateAverage.toStringAsFixed(1);
    }
  }

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
                  BoldText(comments.length.toString() + " Reviews", 20.0,
                      Colors.amber),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 25.0,
                      ),
                      BoldText(getAverage(), 15.0, dayTextColor),
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
