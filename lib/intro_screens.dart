import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen/page_indicator.dart';
import 'package:intro_screen/page_view_model.dart';

class IntroScreens extends StatefulWidget {
  @override
  _IntroScreensState createState() => _IntroScreensState();

  final List<IntroScreen> pages;

  final String skipButtonText;

  final Function onSkip;

  final Function onDone;

  final Color activeDotColor;

  final Color inactiveDotColor;

  const IntroScreens({
    this.pages,
    this.onDone,
    this.onSkip,
    this.activeDotColor,
    this.inactiveDotColor,
    this.skipButtonText = 'skip',
  });
}

class _IntroScreensState extends State<IntroScreens>
    with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController, slideAnimationController;
  Animation<double> _scaleAnimation, _fadeAnimation;
  Animation<Offset> _slideTransition;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    slideAnimationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);

    _fadeAnimation =
        Tween(begin: 0.3, end: 1.0).animate(slideAnimationController);

    _slideTransition = Tween(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(slideAnimationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    slideAnimationController.dispose();

    super.dispose();
  }

  playAnimation() {
    slideAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView.builder(
              itemCount: widget.pages.length,
              onPageChanged: (index) {
                setState(() {
                  if (currentPage == widget.pages.length - 1) {
                    lastPage = true;
//                    animationController.forward();
                  } else {
                    lastPage = false;
//                    animationController.reverse();
                  }
                  currentPage = index;
                });
              },
              controller: _controller,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: playAnimation(),
                  builder: (context, snapshot) => FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideTransition,
                      child: widget.pages[index],
                    ),
                  ),
                );
              }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 18,
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      widget.skipButtonText.toUpperCase(),
                      style: widget.pages[0].textStyle,
                    ),
                    onPressed: widget.onSkip,
                  ),
                  PageIndicator(
                    currentIndex: currentPage,
                    activeDotColor: widget.activeDotColor,
                    inactiveDotColor: widget.inactiveDotColor,
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
                  lastPage
                      ? IconButton(
                          onPressed: widget.onDone,
                          icon: Icon(
                            Icons.check,
                            color: widget.pages[0].textColor,
                          ),
                        )
                      : FlatButton(
                          child: Icon(Icons.arrow_forward),
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
        ],
      ),
    );
  }
}
