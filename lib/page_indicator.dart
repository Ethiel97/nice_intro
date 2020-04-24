import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen/intro_screens.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  final Color activeDotColor;
  final Color inactiveDotColor;
  final IndicatorType type;
  final VoidCallback onTap;

  PageIndicator({
    this.currentIndex,
    this.pageCount,
    this.activeDotColor,
    this.onTap,
    this.inactiveDotColor,
    this.type,
  });

  _indicator(bool isActive) {
    return GestureDetector(
      onTap: this.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: buildIndicatorShape(type, isActive),
      ),
    );
  }

  _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < pageCount; i++) {
      indicatorList
          .add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicators(),
    );
  }

  Widget buildIndicatorShape(type, isActive) {
    if (type == IndicatorType.CIRCLE) {
      return Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? activeDotColor : inactiveDotColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                .02,
              ),
              offset: Offset(0.0, 2.0),
              blurRadius: 2.0,
            )
          ],
        ),
      );
    } else if (type == IndicatorType.LINE) {
      return Container(
        height: 4.8,
        width: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50),
          color: isActive ? activeDotColor : inactiveDotColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                .02,
              ),
              offset: Offset(0.0, 2.0),
              blurRadius: 2.0,
            )
          ],
        ),
      );
    }
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isActive ? activeDotColor : inactiveDotColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                .02,
              ),
              offset: Offset(0.0, 2.0),
              blurRadius: 2.0,
            )
          ],
        ),
      ),
    );
  }
}
