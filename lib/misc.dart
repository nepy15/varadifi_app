import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final db = FirebaseFirestore.instance;

const Color backgroundColor = Color(0xFF131313);
AppBar appBar = AppBar(
  surfaceTintColor: Colors.transparent,
  centerTitle: true,
  backgroundColor: Color.fromARGB(255, 0, 2, 0),
  title: const ImageIcon(
    AssetImage("assets/VaradifiIcon.png"),
    color: Color(0xFFFFFFFF),
    size: 50.0,
  ),
);

class EventData {
  final String? title;
  final String? description;

  EventData({this.title, this.description});
}

void readData() async {
  await db.collection("events").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
}

//appbar
AppBar newAppBar = AppBar(
  centerTitle: true,
  title: Text(
    'Varadifi',
    style: GoogleFonts.manrope(
      color: Color(0xFF00C853),
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),
  backgroundColor: Color(0x60131313),
);

//navbar
class NavBar extends StatefulWidget {
  NavBar({required this.onPressed, required this.currentIndex});

  final Function(int) onPressed;
  final int currentIndex;

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  final items = [
    {'icon': Icons.home, 'label': 'FŐOLDAL'},
    {'icon': Icons.book, 'label': 'ÁHITAT'},
    {'icon': Icons.calendar_month, 'label': 'ALKALMAK'},
    {'icon': Icons.shopping_bag, 'label': 'BOLT'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Color(0x60131313),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == widget.currentIndex;

          return GestureDetector(
            onTap: () {
              widget.onPressed(index);
            },
            child: AnimatedContainer(
              width: isSelected ? 100 : 50,
              curve: Curves.bounceIn,
              duration: Duration(microseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                gradient: LinearGradient(
                  colors: isSelected
                      ? [Color(0xFF3FE56C), Color(0xFF00C853)]
                      : [Colors.transparent, Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[index]['icon'] as IconData,
                    color: isSelected ? Color(0xFF002108) : Color(0xFF78716C),
                  ),
                  SizedBox(height: 4),
                  Visibility(
                    visible: isSelected,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      items[index]['label'] as String,
                      style: TextStyle(
                        color: isSelected
                            ? Color(0xFF002108)
                            : Color(0xFF78716C),
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AllScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}
