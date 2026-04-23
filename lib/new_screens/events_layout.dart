import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varadifi_app/misc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

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
        child: ListView(
          children: [
            _Header(),
            SizedBox(height: 1400, child: _EventsList()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Alkalmak',
                style: GoogleFonts.manrope(
                  color: Color(0xFFE5E2E1),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2.4,
                  fontSize: 48,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF3FE56C),
                  borderRadius: BorderRadius.circular(99999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<_EventsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('events')
          .orderBy('id', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3FE56C),
              semanticsLabel: 'Loading...',
            ),
          );
        }
        final events = snapshot.data!.docs;
        return Container(
          padding: EdgeInsets.only(bottom: 60),
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final isLast = index == events.length - 1;
              return _EventCard(
                marginBottom: isLast ? 800 : 24,
                month: events[index]['month'],
                day: events[index]['day'],
                title: events[index]['title'],
                description: events[index]['description'],
                time: events[index]['time'],
                location: events[index]['location'],
              );
            },
          ),
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final double marginBottom;

  final String month;
  final int day;
  final String title;
  final String description;
  final String time;
  final String location;

  const _EventCard({
    this.marginBottom = 24,
    required this.month,
    required this.day,
    required this.title,
    required this.description,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFF201F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(
        top: 24,
        bottom: marginBottom,
        right: 24,
        left: 24,
      ),
      child: Column(
        children: [
          SizedBox(
            width: 80,
            height: 94,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    month,
                    style: GoogleFonts.manrope(
                      color: Color(0xFF3FE56C),
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      height: 1,
                    ),
                  ),
                  Text(
                    day.toString(),
                    style: GoogleFonts.manrope(
                      color: Color(0xFFE5E2E1),
                      fontWeight: FontWeight.w800,
                      fontSize: 48,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.manrope(
              color: Color(0xFFE5E2E1),
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          Text(
            description,
            style: GoogleFonts.inter(
              color: Color(0xFFBBCBB8),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Color(0xFF3FE56C),
                      size: 18,
                    ),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        color: Color(0xFFE5E2E1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF3FE56C), size: 18),
                    Text(
                      location,
                      style: GoogleFonts.inter(
                        color: Color(0xFFBBCBB8),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
