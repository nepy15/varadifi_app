import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/admin_layout.dart';
import 'package:varadifi_app/screens/events_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:varadifi_app/screens/misc.dart';
import 'package:varadifi_app/screens/shop_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final int event = 0;
  final int shop = 1;
  final int admin = 2;
  final int newEvent = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            children: [
              SizedBox(height: 120),
              _CardLayout(
                title: 'Events',
                imagePath: 'assets/events.png',
                pageID: newEvent,
              ),
              SizedBox(height: 65),
              _CardLayout(
                title: 'Shop',
                imagePath: 'assets/shop.png',
                pageID: admin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardLayout extends StatelessWidget {
  const _CardLayout({
    required this.title,
    required this.imagePath,
    required this.pageID,
  });

  final String title;
  final String imagePath;
  final int pageID;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF111111),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {
          switch (pageID) {
            case 0:
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const EventsPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const ShopPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const AdminPage()),
              );
              break;
            default:
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => AlertDialog(
                  backgroundColor: backgroundColor,
                  title: Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(230, 100, 0, 0),
                    ),
                  ),
                  content: Text('Page ID not found!'),
                ),
              );
          }
        },
        child: Column(
          children: [
            Container(
              width: 350,
              height: 87,
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
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 153,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
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
