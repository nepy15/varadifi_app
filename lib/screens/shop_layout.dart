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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print('button pressed');
              },

              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                minimumSize: const Size(50, 50),
                backgroundColor: Color(0x302B2B2B),
                overlayColor: Colors.green,
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 24,
                color: Color(0xFFFFFFFF),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                print('button pressed');
              },

              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                minimumSize: const Size(50, 50),
                backgroundColor: Color(0x302B2B2B),
                overlayColor: Colors.green,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 24,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
