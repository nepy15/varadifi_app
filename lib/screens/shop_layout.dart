import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
              "Shop",
              style: TextStyle(
                fontSize: 40,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 80),
            _ShopLayout(),
          ],
        ),
      ),
    );
  }
}

class _ShopLayout extends StatelessWidget {
  final double spacer = 35;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: spacer),
            _ShopCard(id: 0),
            SizedBox(width: spacer),
            _ShopCard(id: 1),
            SizedBox(width: spacer),
            _ShopCard(id: 2),
          ],
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF171717),
      ),
      child: Column(
        children: [
          Container(
            width: 270,
            height: 249.82,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Positioned.fill(
                child: Image.asset('shop.png', fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            width: 270,
            height: 69,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Product",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "€9.99",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF202020),
              minimumSize: const Size(240, 44),
              overlayColor: Color(0xFFFFFFFF),
            ),

            onPressed: () {
              print("Bought");
            },

            child: Text(
              "Buy",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
