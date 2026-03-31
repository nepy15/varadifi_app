import 'misc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:ui';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      //appBar: newAppBar,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 50, 0, 50),
          child: _EventsLayout(),
        ),
      ),
    );
  }
}

class _EventsLayout extends StatefulWidget {
  @override
  _EventsLayoutState createState() => _EventsLayoutState();
}

class _EventsLayoutState extends State<_EventsLayout> {
  final db = FirebaseFirestore.instance;
  final eventsList = <_EventsCard>{};

  int eventCount() {
    int count = 0;
    db.collection('events').count().get().then((res) => count = res.count!);

    return count;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection('events').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(color: Color(0xFFFFFFFF));
        }

        var docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var data = docs[index];

            return Padding(
              padding: EdgeInsetsGeometry.only(bottom: 25),
              child: _EventsCard(
                title: data['title'],
                description: data['description'],
                cardImage: 'assets/events.png',
              ),
            );
          },
        );
      },
    );
  }
}

class _EventsCard extends StatelessWidget {
  const _EventsCard({
    required this.title,
    required this.description,
    required this.cardImage,
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Positioned.fill(
                child: Image.asset(cardImage, fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Color(0xFF121212),
            ),
            width: width,
            height: 73,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    height: 34,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight(400),
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: 38,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight(50),
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
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
