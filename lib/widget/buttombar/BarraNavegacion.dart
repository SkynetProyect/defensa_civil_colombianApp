import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/components/BarraVidrio.dart';
import 'package:flutter_application_1/widget/components/objects/Icono.dart';

class BarraNavegacion extends StatelessWidget{

  final ValueChanged<int> callbackfunction; //Si el callback no retorna nada.
  static final List<Icono> _destinosposibles = [
    Icono(imagen: Icon(Icons.map_outlined), titulo: 'mapa' ),
    Icono(imagen: Icon(Icons.radio_outlined), titulo: 'radio' ),
  ];

  const BarraNavegacion({
    super.key,
    required this.callbackfunction,
  });

  @override
  Widget build(BuildContext context){
    return BarraVidrio(opciones: _destinosposibles,
       callbackfunction: callbackfunction,
       rounded: true,
       colorleft: const Color.fromARGB(255, 223, 124, 59),
       colorright: const Color.fromARGB(255, 32, 34, 155));
  }
}