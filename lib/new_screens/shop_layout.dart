import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varadifi_app/screens/misc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

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
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _Header(),
              SizedBox(height: 1400, child: _ProductList()),
            ],
          ),
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

class _ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<_ProductList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('shopItems').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          final products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final isLastItem = index == products.length - 1;
              final product = products[index];
              return _ProductItem(
                marginBottom: isLastItem ? 800 : 64,
                title: product['title'],
                price: product['price'],
                imageUrl: 'assets/VaradifiIcon.png',
                description: product['description'],
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final double marginBottom;
  final String title;
  final double price;
  final String imageUrl;
  final String description;

  const _ProductItem({
    this.marginBottom = 64,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 608,
      margin: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 0,
        bottom: marginBottom,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 456,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ), //image
          SizedBox(
            height: 52,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SizedBox(
                    width: 400,
                    height: 52,
                    child: Column(
                      spacing: 5,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.manrope(
                                color: Color(0xFFE5E2E1),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ), //title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              description,
                              style: GoogleFonts.inter(
                                color: Color(0xFFBBCBB8),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ), //description
                      ],
                    ),
                  ),
                ), //text labels
                Positioned(
                  top: 0,
                  right: 0,
                  child: Text(
                    '\$$price',
                    style: GoogleFonts.manrope(
                      color: Color(0xFF3FE56C),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ), //price
              ],
            ),
          ), //informations
          Container(
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.9, -1.15),
                end: Alignment(0.1, 1.15),
                colors: [Color(0xFF3FE56C), Color(0xFF00C853)],
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                print('pressed');
              },
              splashColor: Color(0x803FE56C),
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Text(
                  'Vasarlas',
                  style: GoogleFonts.manrope(
                    color: Color(0xFF002108),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.4,
                    height: 0.02,
                  ),
                ),
              ),
            ),
          ), //button
        ],
      ),
    );
  }
}
