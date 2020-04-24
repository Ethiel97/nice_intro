import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_screen/page_indicator.dart';
import 'package:intro_screen/page_view_model.dart';
import 'package:tinycolor/tinycolor.dart';

enum IndicatorType { CIRCLE, LINE, DIAMOND }

enum FooterShape { NORMAL, CURVED_TOP, CURVED_BOTTOM }

class IntroScreens extends StatefulWidget {
  @override
  _IntroScreensState createState() => _IntroScreensState();

  final IndicatorType indicatorType;

  final String appTitle;

  final double footerRadius;
  final double viewPortFraction;

  @required
  final List<IntroScreen> pages;

  final String skipButtonText;

  @required
  final Function onSkip;

  @required
  final Function onDone;

  final Color activeDotColor;

  final Color inactiveDotColor;

  final EdgeInsets footerPadding;

  final Color footerBgColor;

  final Color textColor;

  final List<Color> footerGradients;

  const IntroScreens({
    this.pages,
    this.footerRadius = 12.0,
    this.footerGradients = const [],
    this.onDone,
    this.indicatorType = IndicatorType.DIAMOND,
    this.appTitle = '',
    this.onSkip,
    this.activeDotColor = Colors.white,
    this.inactiveDotColor,
    this.skipButtonText = 'skip',
    this.viewPortFraction = 1.0,
    this.textColor = Colors.white,
    this.footerPadding = const EdgeInsets.all(24),
    this.footerBgColor = const Color(0xff51adf6),
  }) : assert(pages.length > 0);
}

class _IntroScreensState extends State<IntroScreens>
    with TickerProviderStateMixin {
  PageController _controller;
  double pageOffset = 0;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  IntroScreen currentScreen;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: widget.viewPortFraction,
    )..addListener(() {
        pageOffset = _controller.page;
      });

    currentScreen = widget.pages[0];

    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  TextStyle get textStyle =>
      currentScreen.textStyle ??
      GoogleFonts.lato(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal);

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  bool get existGradientColors => widget.footerGradients.length > 0;

  LinearGradient get gradients => existGradientColors
      ? LinearGradient(
          colors: widget.footerGradients,
          begin: Alignment.topLeft,
          end: Alignment.topRight)
      : LinearGradient(
          colors: [
            widget.footerBgColor,
            widget.footerBgColor,
          ],
        );

  int getCurrentPage() {
    return _controller.page.floor();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            TinyColor(currentScreen?.headerBgColor).setOpacity(.8).color ??
                Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor:
            currentScreen?.headerBgColor ?? Colors.transparent,
      ),
      child: Container(
        color: Colors.white,
//        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          overflow: Overflow.visible,
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
                itemCount: widget.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                    currentScreen = widget.pages[currentPage];
                    if (currentPage == widget.pages.length - 1) {
                      lastPage = true;
                      animationController.forward();
                    } else {
                      lastPage = false;
                      animationController.reverse();
                    }
                  });
                },
                controller: _controller,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == pageOffset.floor()) {
                    return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return buildPage(
                            index: index,
                            angle: pageOffset - index,
                          );
                        });
                  } else if (index == pageOffset.floor() + 1) {
                    return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return buildPage(
                            index: index,
                            angle: pageOffset - index,
                          );
                        });
                  }
                  return buildPage(index: index);
                }),

            //footer widget
            Positioned.fill(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * .66,
              child: Container(
                padding: widget.footerPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.footerRadius.toDouble()),
                    topLeft: Radius.circular(widget.footerRadius.toDouble()),
                  ),
                  color: widget.footerBgColor,
                  gradient: gradients,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        currentScreen.title,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle?.apply(
                          color: widget.textColor,
                          fontWeightDelta: 12,
                          fontSizeDelta: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        currentScreen.description,
                        softWrap: true,
                        style: textStyle?.apply(
                          color: TinyColor(widget.textColor).darken(8).color,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),

            //controls widget
            Positioned(
              left: 0,
              right: 0,
              bottom: 18,
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IgnorePointer(
                        ignoring: lastPage,
                        child: Opacity(
                          opacity: lastPage ? 0.0 : 1.0,
                          child: FlatButton(
                            child: Text(
                              widget.skipButtonText.toUpperCase(),
                              style: textStyle,
                            ),
                            onPressed: widget.onSkip,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 160,
                        child: PageIndicator(
                          type: widget.indicatorType,
                          currentIndex: currentPage,
                          activeDotColor: widget.activeDotColor,
                          inactiveDotColor: widget.inactiveDotColor ??
                              widget.activeDotColor.withOpacity(.5),
                          pageCount: widget.pages.length,
                          onTap: () {
                            _controller.animateTo(
                              _controller.page,
                              duration: Duration(
                                milliseconds: 400,
                              ),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                        ),
                      ),
                      Spacer(),
                      lastPage
                          ? FlatButton(
                              onPressed: widget.onDone,
                              child: Icon(
                                Icons.check,
                                size: 28,
                                color: widget.textColor,
                              ),
                            )
                          : FlatButton(
                              child: Icon(
                                Icons.arrow_forward,
                                size: 28,
                                color: widget.textColor,
                              ),
                              onPressed: () {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.fastOutSlowIn);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),

            //app title
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.appTitle,
                  style: textStyle.apply(
                      fontSizeDelta: 12, fontWeightDelta: 8, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({int index, double angle = 0.0, double scale = 1.0}) {
    print(pageOffset - index);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform(
          child: widget.pages[index],
          transform: Matrix4.identity()
            ..setEntry(3, 2, .001)
            ..rotateY(angle),
        ),
        Positioned.fill(
          left: 0,
          right: 0,
          bottom: 12,
          top: MediaQuery.of(context).size.height * .45,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.0,
                sigmaY: 1.0,
              ),
              child: Container(
                width: double.infinity,
                color: currentScreen.headerBgColor.withOpacity(.002),
              ),
            ),
          ),
        )
      ],
    );
  }
}
