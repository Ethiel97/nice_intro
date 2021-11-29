import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  ///This is a builder for an intro screen
  ///
  ///

  /// title of your slide
  ///[String]
  final String? title;

  ///description of your slide
  ///[String]
  final String? description;

  ///image path for your slide
  ///[String]
  final String? imageAsset;

  ///textStyle for your slide
  ///[TextStyle]
  final TextStyle? textStyle;

  ///background color for your slide header
  ///[Color]
  final Color headerBgColor;

  ///padding for the your slide header
  ///[EdgeInsets]
  final EdgeInsets headerPadding;

  ///widget to use as the header part of your screen
  ///[Widget]
  final Widget? header;

  const IntroScreen({
    required String this.title,
    this.headerPadding = const EdgeInsets.all(12),
    required String this.description,
    this.header,
    this.headerBgColor = Colors.white,
    this.textStyle,
    this.imageAsset,
    Key? key,
  }) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int? _pageIndex;

  set index(val) => _pageIndex = val;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: screenSize.height,
      child: Column(
        children: <Widget>[
          Container(
            height: screenSize.height * .666,
            padding: widget.headerPadding,
            decoration: BoxDecoration(
              color: widget.headerBgColor,
            ),
            child: Center(
              child: widget.imageAsset != null
                  ? Image.asset(
                      widget.imageAsset!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: screenSize.height * .3,
                    )
                  : widget.header ??
                      Text(
                        '${_pageIndex ?? 1}',
                        style: const TextStyle(
                          fontSize: 300,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
