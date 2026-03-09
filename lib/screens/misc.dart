import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

const Color backgroundColor = Color(0xFF080A08);
AppBar appBar = AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          backgroundColor:Color.fromARGB(255, 0, 2, 0),
          title: const ImageIcon(AssetImage("assets/VaradifiIcon.png"), color: Color(0xFFFFFFFF), size: 50.0,),
        );

class EventData {
  final String? title;
  final String? description;

  EventData({
    this.title,
    this.description,
  });
}

void readData() async {
  await db.collection("events").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
}