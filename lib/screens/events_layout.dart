import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

final db = FirebaseFirestore.instance;

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 23),
            Text(
              'Events',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF)
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 65),
            _EventsCard(title: 'Title', description: "This is a test for event descriptions and other optional things, like tags, good to knows etc.", cardImage: 'assets/events.png'),
            SizedBox(height: 40),
            _EventsCard(title: 'Title', description: "This is a test for event descriptions and other optional things, like tags, good to knows etc.", cardImage: 'assets/events.png'),
            SizedBox(height: 40),
            _EventsCard(title: 'Title', description: "This is a test for event descriptions and other optional things, like tags, good to knows etc.", cardImage: 'assets/events.png'),
            SizedBox(height: 40),
            _EventsCard(title: 'Title', description: "This is a test for event descriptions and other optional things, like tags, good to knows etc.", cardImage: 'assets/events.png'),
            SizedBox(height: 40),
            
          ],
        ),
      )
    );
  }
}

class _EventsCard extends StatelessWidget {
  const _EventsCard({
    required this.title,
    required this.description,
    required this.cardImage
  });

  final String title;
  final String description;
  final String cardImage;

  final double width = 270;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 218,
      child: Column(
        children: [
          Container(
            height: 145,
            width: width,
            decoration: BoxDecoration( borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Positioned.fill(child: Image.asset(cardImage, fit: BoxFit.cover))
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), color: Color(0xFF121212)),
            width: width,
            height: 73,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    height: 34,
                    child: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight(400), color: Color(0xFFFFFFFF)), textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    width: width,
                    height: 38,
                    child: Text(description, style: TextStyle(fontSize: 10, fontWeight: FontWeight(50), color: Color(0xFFFFFFFF)), textAlign: TextAlign.center),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}