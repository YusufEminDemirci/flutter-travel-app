import 'package:flutter/material.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class CityInfo extends StatelessWidget {
  const CityInfo({
    Key key,
    @required this.telephone,
    @required this.hours,
    @required this.description,
  }) : super(key: key);

  final String telephone;
  final Map hours;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText("Telephone: ", 20.0, kblack),
                  NormalText(telephone, kblack, 15.0),
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText("Hours: ", 20.0, kblack),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      NormalText("MONDAY / " + hours["Monday"], kblack, 12.0),
                      NormalText("TUESDAY / " + hours["Tuesday"], kblack, 12.0),
                      NormalText(
                          "WEDNESDEY / " + hours["Wednesday"], kblack, 12.0),
                      NormalText(
                          "THURSDAY / " + hours["Thursday"], kblack, 12.0),
                      NormalText("FRIDAY / " + hours["Friday"], kblack, 12.0),
                      NormalText(
                          "SATURDAY / " + hours["Saturday"], kblack, 12.0),
                      NormalText("SUNDAY / " + hours["Sunday"], kblack, 12.0),
                    ],
                  )
                ],
              ),
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BoldText("About this place", 20.0, kblack),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          NormalText(description, kblack, 12.0),
        ],
      ),
    );
  }
}
