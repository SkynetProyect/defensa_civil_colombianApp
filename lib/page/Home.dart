import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/Mapa.dart';
import 'package:flutter_application_1/widget/buttombar/BarraNavegacion.dart';
import 'package:flutter_application_1/widget/components/Brujula.dart';
import 'package:flutter_application_1/widget/topbar/TopBar.dart';


class Application extends StatefulWidget{  
  const Application({super.key});

  @override
  State<Application> createState() => _Home();
}

class _Home extends State<Application>{
  int _selectedIndex = 0;
  List<Widget> pantalla = [Mapa(), Brujula()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(248, 179, 174, 174),
        appBar: TopBar(),
        body: 
        Stack(
        alignment: Alignment.bottomCenter,
        children: [
        pantalla[_selectedIndex],
        BarraNavegacion(callbackfunction: (numero){
          setState((){
            _selectedIndex = numero;
          });
          print(_selectedIndex);
          })
        ]
      )
      );
  }
}