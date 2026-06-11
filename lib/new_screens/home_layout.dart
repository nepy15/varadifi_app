import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varadifi_app/misc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:varadifi_app/new_screens/shop_layout.dart';

const miniScreenMaxWidth = 390;
final db = FirebaseFirestore.instance;

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onNavigate});

  final Function(int) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Center(
            child: Text(
              'Váradifi',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3FE56C),
              ),
            ),
          ),
          _HeroImage(),
          _GatheringCard(),
          _FeaturedMerch(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 18, left: 18, top: 48, bottom: 45),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0x15FFFFFF),
        border: Border.all(color: Color(0xFF3FE56C), width: 1.5),
      ),
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [Image.asset('assets/hero.png', fit: BoxFit.cover)],
        ),
      ),
    );
  }
}

class _FeaturedEvent extends StatefulWidget {
  @override
  State<_FeaturedEvent> createState() => _FeaturedEventState();
}

class _FeaturedEventState extends State<_FeaturedEvent> {
  String eventTitle = '';
  String eventDescription = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection('events').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final event = snapshot.data!.docs
              .where((doc) => doc['featured'] == true)
              .first;
          eventTitle = event['title'];
          eventDescription = event['description'];
        } else if (!snapshot.hasData) {
          return Text(
            'Adatok betöltése...',
            style: GoogleFonts.inter(
              color: Color(0xFF3FE56C),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          );
        }
        return Container(
          height: 427.5,
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Color(0xFF131313),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset('assets/events.png', fit: BoxFit.cover),
                Positioned.fill(
                  child: Transform.scale(
                    scale: 1.6,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF131313),
                            Color(0x50131313),
                            Color(0x00131313),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 0,
                    top: 116.5,
                    left: 15,
                    right: 15,
                  ),
                  height: 311,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          color: Color(0xFF00C853),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'MAJOR EVENT',
                            style: GoogleFonts.inter(
                              color: Color(0xFF004C1B),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        eventTitle,
                        style: GoogleFonts.manrope(
                          color: Color(0xFFE5E2E1),
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                          letterSpacing: -1.8,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                        child: SizedBox(
                          height: 72,
                          width: 278,
                          child: Text(
                            eventDescription,
                            style: GoogleFonts.inter(
                              color: Color(0xFFBBCBB8),
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        spacing: 16.0,
                        children: [
                          _Button(
                            splashColor: Color(0xFF3FE56C),
                            shadow: [
                              BoxShadow(
                                color: Color(0x203FE56C),
                                blurRadius: 25,
                                spreadRadius: -5,
                                offset: Offset(0, 20),
                              ),
                              BoxShadow(
                                color: Color(0x2000C853),
                                blurRadius: 10,
                                spreadRadius: -6,
                                offset: Offset(0, 8),
                              ),
                            ],

                            onPressed: () {
                              print('pressed');
                            },

                            gradient: LinearGradient(
                              begin: Alignment(-0.3, -1.6),
                              end: Alignment(0.3, 1.6),
                              colors: [Color(0xFF3FE56C), Color(0xFF00C853)],
                            ),
                            child: Text(
                              'Leszek!',
                              style: GoogleFonts.manrope(
                                color: Color(0xFF002108),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),
                          _Button(
                            onPressed: () {
                              print('pressed');
                            },
                            splashColor: Color(0x15E5E2E1),
                            color: Color(0x95201F1F),
                            child: Text(
                              'Details',
                              style: GoogleFonts.manrope(
                                color: Color(0xFFE5E2E1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final Function onPressed;
  final List<BoxShadow>? shadow;
  final Color? color;
  final Color splashColor;

  const _Button({
    required this.child,
    required this.onPressed,
    required this.splashColor,
    this.gradient,
    this.shadow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        boxShadow: shadow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          onTap: () => onPressed(),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class _FeaturedMerch extends StatefulWidget {
  final Function(int) onNavigate;

  const _FeaturedMerch({required this.onNavigate});

  @override
  _FeaturedMerchState createState() => _FeaturedMerchState();
}

class _FeaturedMerchState extends State<_FeaturedMerch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection('shopItems').snapshots(),
      builder: (context, snapshot) {
        final docs = snapshot.data?.docs;
        if (!snapshot.hasData) {
          return Text(
            'Adatok betöltése...',
            style: GoogleFonts.inter(
              color: Color(0xFF3FE56C),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return Column(
          children: [
            SizedBox(
              height: 25,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 24,
                    child: Text(
                      'Váradifis merch-ek',
                      style: GoogleFonts.manrope(
                        color: Color(0xFFE5E2E1),
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 24,
                    child: SizedBox(
                      width: 60.04,
                      child: GestureDetector(
                        onTap: () {
                          widget.onNavigate(3);
                        },
                        child: Row(
                          children: [
                            Text(
                              'BOLT',
                              style: GoogleFonts.inter(
                                color: Color(0xFF3FE56C),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 1.4,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF3FE56C),
                              size: 10.75,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 500,
              child: ScrollConfiguration(
                behavior: AllScrollBehavior(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: docs!.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data();
                    return _ShopItem(
                      imagePath: data['imagePath'],
                      title: data['title'] as String,
                      price: data['price'] as double,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 80),
          ],
        );
      },
    );
  }
}

class _ShopItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final double price;

  const _ShopItem({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  _ShopItemState createState() => _ShopItemState();
}

class _ShopItemState extends State<_ShopItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 580,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 0, right: 15, bottom: 7),
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFF1C1B1B),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(widget.imagePath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 24,
                  child: Text(
                    widget.title,
                    style: GoogleFonts.manrope(
                      color: Color(0xFFE5E2E1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 24,
                  child: Text(
                    "${widget.price} RON",
                    style: GoogleFonts.manrope(
                      color: Color(0xFFBBCBB8),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GatheringCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: Column(
        children: [
          SizedBox(
            width: 342,
            height: 50,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    "HETI ALKALMAK",
                    style: GoogleFonts.manrope(
                      color: Color(0xFFE5E2E1),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Text(
                    "Találkozzunk minden héten!",
                    style: GoogleFonts.inter(
                      color: Color(0xFFE5E2E1),
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _EventCard(
            title: "Ifi alkalom",
            time: "Szerda, 19:00",
            place: "Kerekterem",
            icon: Icons.people,
          ),
          _EventCard(
            title: "Gyülekezeti alkalom",
            time: "Csütörtök, 18:00",
            place: "Nagyterem",
            icon: Icons.church,
          ),
          _EventCard(
            title: "Gyülekezeti alkalom",
            time: "Vasárnap, 10:00 & 18:00",
            place: "Nagyterem",
            icon: Icons.church,
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatefulWidget {
  final String title;
  final String time;
  final String place;
  final IconData icon;

  const _EventCard({
    required this.title,
    required this.time,
    required this.place,
    required this.icon,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 104,
      decoration: BoxDecoration(
        color: Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: SizedBox(
              width: 254.47,
              height: 64,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 46.78,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0x103FE56C),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Center(
                      child: Icon(
                        widget.icon,
                        size: 23,
                        color: Color(0xFF3FE56C),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 187.69,
                    height: 64,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.manrope(
                            color: Color(0xFFE5E2E1),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${widget.time} - ${widget.place}',
                          style: GoogleFonts.inter(
                            color: Color(0xFFBBCBB8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*Positioned(
            top: 20,
            right: 20,
            bottom: 20,
            child: SizedBox(
              height: 64,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFBBCBB8),
                  size: 25,
                ),
              ),
            ),
            ),*/
        ],
      ),
    );
  }
}
