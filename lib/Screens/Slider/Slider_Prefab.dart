import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_food/Screens/Slider/Dots.dart';
import 'package:travel_food/Screens/Slider/Items.dart';

import 'Slider.dart';

class Slider_Prefab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Slider_PrefabState();
}

class _Slider_PrefabState extends State<Slider_Prefab> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: sliderArrayList.length,
                itemBuilder: (ctx, i) => Items(i),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < sliderArrayList.length; i++)
                          if (i == _currentPage) Dots(true) else Dots(false)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
