import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

@immutable
class IntroScreen extends StatelessWidget {
  ///This is a builder for an intro screen
  ///
  ///

  final List<Color> footerGradients;

  final String title;

  final String description;

  final Color footerColor;

  final Color footerTextColor;

  final String imageAsset;

  final TextStyle textStyle;

  final Color headerColor;

  final EdgeInsets headerPadding;

  final EdgeInsets footerPadding;

  final Color textColor;

  const IntroScreen({
    this.title,
    this.headerPadding = const EdgeInsets.all(12),
    this.footerPadding = const EdgeInsets.all(12),
    this.footerGradients = const [],
    this.description,
    this.headerColor,
    this.textColor = Colors.white,
    this.footerTextColor,
    this.footerColor,
    this.textStyle,
    this.imageAsset,
  })  : assert(imageAsset != null),
        assert(title != null),
        assert(description != null),
        assert(title != null);

  bool get existGradientColors => footerGradients.length > 0;

  LinearGradient get gradients => existGradientColors
      ? LinearGradient(
          colors: footerGradients,
          begin: Alignment.topLeft,
          end: Alignment.topRight)
      : LinearGradient(colors: [
          footerColor,
          footerColor,
        ]);

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
            decoration: BoxDecoration(color: headerColor),
            child: Center(
              child: Image.asset(
                imageAsset,
              ),
            ),
          ),
          Container(
            padding: footerPadding,
            decoration: BoxDecoration(
              color: footerColor,
              gradient: gradients,
            ),
            height: screenSize.height * .333,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: textStyle.apply(
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    description,
                    style: textStyle.apply(
                      color: TinyColor(textColor).lighten().color,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
