import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varadifi_app/screens/misc.dart';

const miniScreenMaxWidth = 390;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: NavBar(),
        ),
      ),
      body: ListView(children: [_FeaturedEvent(), _FeaturedMerch()]),
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
                    'EVENT TITLE',
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
                        'Join thousands for a weekend that will redefine yout path. Registration opens Monday.',
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
                          'Get Tickets',
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
  @override
  _FeaturedMerchState createState() => _FeaturedMerchState();
}

class _FeaturedMerchState extends State<_FeaturedMerch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      child: Column(
        children: [
          SizedBox(
            height: 32,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 24,
                  child: Text(
                    'FEATURED MERCH',
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
                    width: 93.04,
                    child: Row(
                      children: [
                        Text(
                          'SHOP ALL',
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
                          size: 8.75,
                        ),
                      ],
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
