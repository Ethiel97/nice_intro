import 'package:flutter/material.dart';
import 'package:nice_intro/intro_screen.dart';
import 'package:nice_intro/intro_screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'intro screen demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var screens = IntroScreens(
      onDone: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NextPage(),
        ),
      ),
      onSkip: () => print('Skipping the intro slides'),
      footerBgColor: Colors.blue.withOpacity(.8),
      activeDotColor: Colors.white,
      footerRadius: 18.0,
//      indicatorType: IndicatorType.CIRCLE,
      slides: const [
        IntroScreen(
          title: 'Search',
          imageAsset: 'assets/img/1.png',
          description: 'Quickly find all your messages',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'Focused Inbox',
          headerBgColor: Colors.white,
          imageAsset: 'assets/img/2.png',
          description: "We've put your most important, actionable emails here",
        ),
        IntroScreen(
          title: 'Social',
          headerBgColor: Colors.white,
          imageAsset: 'assets/img/3.png',
          description: 'Keep talking with your mates',
        ),
      ],
    );

    return Scaffold(
      body: screens,
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
