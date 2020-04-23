import 'package:flutter/material.dart';

@immutable
class IntroScreen extends StatelessWidget {
  ///This is a builder for an intro screen
  ///
  ///

  final String title;

  final String description;

  final String imageAsset;

  final TextStyle textStyle;

  final Color headerBgColor;

  final EdgeInsets headerPadding;

  const IntroScreen({
    this.title,
    this.headerPadding = const EdgeInsets.all(12),
    this.description,
    this.headerBgColor = Colors.white,
    this.textStyle,
    this.imageAsset,
  })  : assert(imageAsset != null),
        assert(title != null),
        assert(description != null),
        assert(title != null);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height,
      child: Column(
        children: <Widget>[
          Container(
            height: screenSize.height * .666,
            padding: headerPadding,
            decoration: BoxDecoration(
              color: headerBgColor,
            ),
            child: Center(
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                width: double.infinity,
                height: screenSize.height * .3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
