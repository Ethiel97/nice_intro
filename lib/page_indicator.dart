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
        child: Container(
          height: type == IndicatorType.CIRCLE ? 8.0 : 4.8,
          width: type == IndicatorType.CIRCLE ? 8.0 : 24.0,
          decoration: BoxDecoration(
            borderRadius: type == IndicatorType.CIRCLE
                ? null
                : BorderRadius.circular(50.0),
            shape: type == IndicatorType.CIRCLE
                ? BoxShape.circle
                : BoxShape.rectangle,
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
}
