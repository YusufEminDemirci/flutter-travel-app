import 'package:flutter/material.dart';
import '../../Utils/Buttons.dart';
import '../../Utils/TextStyles.dart';
import '../../Utils/consts.dart';
import '../Login_Register/Login.dart';
import 'Slider.dart';

class Items extends StatelessWidget {
  final int index;

  Items(this.index);

  @override
  Widget build(BuildContext context) {
    onPressed() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new Login()),
          ModalRoute.withName("/Home"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(sliderArrayList[index].sliderImageUrl))),
        ),
        SizedBox(
          height: 60.0,
        ),
        BoldText(sliderArrayList[index].sliderHeading, 20.5, dayTextColor),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: index != 2
                  ? NormalText(sliderArrayList[index].sliderSubHeading,
                      dayTextColor, 12.5)
                  : Column(
                      children: <Widget>[
                        NormalText(sliderArrayList[index].sliderSubHeading,
                            dayTextColor, 12.5),
                        SizedBox(
                          height: 50,
                        ),
                        WideButton("Lets go !!", onPressed),
                      ],
                    )),
        ),
      ],
    );
  }
}
