import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

import 'dart:ui';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: newAppBar,
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
            SizedBox(height: 150),
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
            for (int i = 0; i < 3; i++) _ShopCard(id: i),
            SizedBox(width: spacer),
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
      margin: EdgeInsets.only(left: _ShopLayout().spacer),
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
          SizedBox(height: 10),
          SizedBox(
            width: 270,
            height: 69,
            child: Center(
              child: Column(
                children: [
                  Text(
                    switch (id) {
                      0 => 'Hoodie',
                      1 => 'T-Shirt',
                      2 => 'sweater',
                      _ => 'error',
                    },
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    switch (id) {
                      0 => '€11.99',
                      1 => '€9.99',
                      2 => '€9.99',
                      _ => 'error',
                    },
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color(0xFF080A08),
                    title: Center(
                      child: Text(
                        'Almost done!',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    content: SizedBox(
                      width: 309,
                      height: 277,
                      child: Center(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                fillColor: Color(0x10FFFFFF),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                fillColor: Color(0x10FFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Buy now'),
                      ),
                    ],
                  );
                },
              );
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
