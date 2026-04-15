import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varadifi_app/new_screens/events_layout.dart';
import 'package:varadifi_app/misc.dart';
import 'package:varadifi_app/new_screens/home_layout.dart';
import 'package:varadifi_app/new_screens/shop_layout.dart';

import 'dart:ui';

class FinalView extends StatefulWidget {
  @override
  FinalViewState createState() => FinalViewState();
}

class FinalViewState extends State<FinalView> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(onNavigate: animateToPage),
      EventsLayout(),
      ShopLayout(),
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: newAppBar,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: _pageController,
                children: screens,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: NavBar(
                    currentIndex: currentIndex,
                    onPressed: (val) {
                      animateToPage(val);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
