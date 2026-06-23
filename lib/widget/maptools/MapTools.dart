
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/components/Brujula.dart';
import 'package:flutter_application_1/widget/components/MenuCircular.dart';

class MapTools extends StatefulWidget {
  
  static List<Widget> herramientas = [
    Icon(Icons.explore_outlined),
    Container(),
    //Icon(Icons.draw_outlined),
    Container(),
    Container()
  ];
  
  static const Widget menu = Icon(Icons.auto_graph);
  Widget brujula = Brujula();
  MapTools({super.key});

  @override
  State<StatefulWidget> createState() => _mapTools();
    
}

class _mapTools extends State<MapTools>{
  bool _mostrarbrujula = false;

  void fnc_mostrarbrujula(){
    setState(() {
      _mostrarbrujula = !_mostrarbrujula;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
        Stack(
        children: [
        MenuCircular(menu: MapTools.menu, herramientas: MapTools.herramientas, fnc1: fnc_mostrarbrujula),
        _mostrarbrujula ? widget.brujula : Container()  
        ]);
    
  }
  

}