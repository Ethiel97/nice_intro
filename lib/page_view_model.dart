import 'package:flutter/material.dart';

@immutable
class IntroScreen extends StatelessWidget {
  ///This is a builder for an intro screen
  ///
  ///

  /// title of your slide
  ///[String]
  final String title;

  ///description of your slide
  ///[String]
  final String description;

  ///image path for your slide
  ///[String]
  final String imageAsset;

  ///textStyle for your slide
  ///[TextStyle]
  final TextStyle textStyle;

  ///background color for your slide header
  ///[Color]
  final Color headerBgColor;

  ///padding for the your slide header
  ///[EdgeInsets]
  final EdgeInsets headerPadding;

  const IntroScreen({
    @required this.title,
    this.headerPadding = const EdgeInsets.all(12),
    @required this.description,
    this.headerBgColor = Colors.white,
    this.textStyle,
    @required this.imageAsset,
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
