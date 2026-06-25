
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/components/Brujula.dart';
import 'package:flutter_application_1/widget/components/Dibujo.dart';
import 'package:flutter_application_1/widget/components/MenuCircular.dart';

class MapTools extends StatefulWidget {
  
  static List<Widget> herramientas = [
    Icon(Icons.explore_outlined),
    Icon(Icons.draw_outlined),
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
  bool _permitirdibujo = false;
  

  void fnc_permitirdibujo(){
    setState(() {
      _permitirdibujo = !_permitirdibujo;
    });
  }

  void fnc_mostrarbrujula(){
    setState(() {
      _mostrarbrujula = !_mostrarbrujula;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget dibujo = Dibujo();

    return Stack(
        alignment: Alignment.center,
        children: [
        _mostrarbrujula ? widget.brujula : Container(),
        _permitirdibujo ? dibujo : Container(),
        MenuCircular(menu: MapTools.menu, herramientas: MapTools.herramientas, 
                  fnc1: fnc_mostrarbrujula, fnc2: fnc_permitirdibujo),

        ]);
    
  }
  

}