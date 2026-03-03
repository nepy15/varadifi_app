import 'package:flutter/material.dart';

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