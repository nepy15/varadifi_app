import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

class EventsLayout extends StatefulWidget {
  @override
  _EventsLayoutState createState() => _EventsLayoutState();
}

class _EventsLayoutState extends State<EventsLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 50, 0, 50),
          child: Text('Events Layout'),
        ),
      ),
    );
  }
}
