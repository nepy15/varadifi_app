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
            SizedBox(height: 50),
            _ShopLayout(),
          ],
        ),
      ),
    );
  }
}

class _ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375,
      child: Center(
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                print("pressed");
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                fixedSize: Size.fromRadius(30),
              ),
              child: Text("<"),
            ),
          ],
        ),
      ),
    );
  }
}
