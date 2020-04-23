import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  final Color activeDotColor;
  final Color inactiveDotColor;
  final VoidCallback onTap;

  PageIndicator({
    this.currentIndex,
    this.pageCount,
    this.activeDotColor,
    this.onTap,
    this.inactiveDotColor,
  });

  _indicator(bool isActive) {
    return GestureDetector(
      onTap: this.onTap,
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: isActive ? activeDotColor : inactiveDotColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    .15,
                  ),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 2.0,
                )
              ],
            ),
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
      children: _buildPageIndicators(),
    );
  }
}
