import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/Home.dart';


void main() {
  runApp(const Main());
}

class Main extends StatelessWidget{

  const Main();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Defensa Civil Colombiana",
      home: Application(),
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        )
      )
    );
  }
}