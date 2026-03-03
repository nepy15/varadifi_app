import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:varadifi_app/screens/misc.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'New Event',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 40,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 50),
            _FormLayout()
          ],
        ),
      ),
    );
  }
}

class _FormLayout extends StatefulWidget {
  
  @override
  _FormLayoutState createState() => _FormLayoutState();
}

class _FormLayoutState extends State<_FormLayout> {

  final db = FirebaseFirestore.instance;

  int letterCount = 97;
  int lettersLeft = 97;
  bool noLettersLeft = false;
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 301,
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Color(0xFFFFFFFF)),

                onSubmitted: (value) {
                  title = value;
                  db.collection('events').doc(value).set({"name": value});
                  print(title);
                },
                decoration: InputDecoration(
                 labelText: 'Title',
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                 filled: true,
                 fillColor: Color(0xFF121212),
                 labelStyle: TextStyle(color: Color(0x15FFFFFF), letterSpacing: 10, fontWeight: FontWeight.w500),
                ),
              ),

              SizedBox(height: 40),

              TextField(
                keyboardType: TextInputType.text,
                style: TextStyle(color: Color(0xFFFFFFFF)),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 6,
                maxLength: 97,

                onSubmitted: (value) {
                  description = value;
                  print(description);
                },
                onChanged: (value) {
                  setState(() {
                    lettersLeft = letterCount - value.toString().length;
                  });
                },

                decoration: InputDecoration(
                  labelText: 'Description',
                  helperText: "Maximum $lettersLeft characters",
                  labelStyle: TextStyle(color: Color(0x15FFFFFF), letterSpacing: 10, overflow: TextOverflow.clip, fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: Color(0xFF121212),
                  contentPadding: const EdgeInsets.only(bottom: 124),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Container(
                    height: 124,
                    width: 124,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF121212), border: Border.all(width: 1, color: Color(0x45FFFFFF))),
                    child: Center(child: Text('Image'),),
                  ),
                  SizedBox(width: 50),
                  Container(
                    width: 124,
                    height: 48,
                    decoration: BoxDecoration(color: Color(0xFF121212), borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Color(0x45FFFFFF))),
                    child: Center(child: Text('Upload'),),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}