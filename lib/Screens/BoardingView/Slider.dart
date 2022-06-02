import 'package:flutter/cupertino.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider(
      {@required this.sliderImageUrl,
      @required this.sliderHeading,
      @required this.sliderSubHeading});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/one.png',
      sliderHeading: "Tour Guide!",
      sliderSubHeading:
          "Live the best and easiest traveling experience with us,the fastest and most reliable option you can ever find."),
  Slider(
      sliderImageUrl: 'assets/two.png',
      sliderHeading: "Hundreds of Places",
      sliderSubHeading:
          "Live the best and easiest traveling experience with us,the fastest and most reliable option you can ever find."),
  Slider(
      sliderImageUrl: 'assets/three.png',
      sliderHeading: "Easy to Use!",
      sliderSubHeading:
          "Live the best and easiest traveling experience with us,the fastest and most reliable option you can ever find."),
];
