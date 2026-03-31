import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

class ShopLayout extends StatefulWidget {
  @override
  _ShopLayoutState createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 50, 0, 50),
          child: Text('Shop Layout'),
        ),
      ),
    );
  }
}
