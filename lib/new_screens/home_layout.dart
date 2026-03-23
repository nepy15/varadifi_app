import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: NavBar(),
        ),
      ),
      body: ListView(children: [

        ],
      ),
    );
  }
}
