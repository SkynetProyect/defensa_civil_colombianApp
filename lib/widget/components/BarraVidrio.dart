
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_application_1/widget/components/objects/Icono.dart'; 
/*
Statefull widget creado para simular el minimalismo de la barra de navegacion de iOS 26 con el aditivo de
un gradiente de 2 colores en el vidrio.
El componente requiere la lista de opciones,
un bool si se desea redondear, 
la funcion callback para extraer el valor cambiado,
el color izquiero y derecho.
Cualquier duda sea buen estudiante y preguntele a la IA.
Att Lenin.
*/

class BarraVidrio extends StatefulWidget {
  final List<Icono> opciones;
  final ValueChanged<int> callbackfunction;
  final bool rounded;
  final Color colorleft;
  final Color colorright;

  BarraVidrio({
    super.key,
    required this.opciones,
    required this.callbackfunction,
    required this.rounded,
    required this.colorleft,
    required this.colorright
  });

  @override
  State<BarraVidrio> createState() => _SelectedPosition();

}

class _SelectedPosition extends State<BarraVidrio>{
  Offset position = const Offset(8, 0);
  double alturaselector = 60.0;
  late List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(widget.opciones.length, (_) => GlobalKey()); 
      WidgetsBinding.instance.addPostFrameCallback((_) {
    _jumpToIndex(0); 
  });
  }

  void _jumpToIndex(int index) {
    final box = _keys[index].currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final itemPosition = box.localToGlobal(Offset.zero);         // item pos on screen
    final stackBox = context.findRenderObject() as RenderBox;
    final stackPosition = stackBox.localToGlobal(Offset.zero);   // stack pos on screen

    final double relativeX = itemPosition.dx - stackPosition.dx; // relative to stack
    final double itemWidth = box.size.width;
    const double selectorWidth = 80.0;
    
    setState((){ 
      widget.opciones.forEach((icono){
        icono.imagen = Icon(icono.imagen.icon, color: Color.fromARGB(199, 0, 0, 0));
      });
      widget.opciones[index].imagen = Icon(widget.opciones[index].imagen.icon, color: Color.fromARGB(200, 255, 255, 255));
      position = Offset(
        relativeX + (itemWidth / 2) - (selectorWidth / 2),
        position.dy,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 30),
        child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none, 
            children: [   
            ClipRRect( 
              borderRadius: widget.rounded ? BorderRadiusGeometry.circular(100) : BorderRadiusGeometry.circular(5),
              child:  BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: 
              Container(
                height: 50,
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 151, 139, 139).withValues(alpha: 0.5),   // semi-transparent fill
                borderRadius: widget.rounded ? BorderRadius.circular(100) : BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),  // bright top/left edge
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.colorleft,      
                    widget.colorright,     
                  ],
                ),
                ),
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: widget.opciones.asMap().entries.map((entry) {
                    int index = entry.key;
                    var seleccionable = entry.value;
                    return GestureDetector(
                      onTapDown: (_) {
                        _jumpToIndex(index);
                        widget.callbackfunction(index);
                      },
                      child: Container(
                        key: _keys[index],
                        height: 50,
                        width: 40,                        
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Center(
                          child: Column(
                            children: [seleccionable.imagen, Text(seleccionable.titulo)],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                )
                )
              ),
            AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            left: position.dx,
            top: -5,
            child: 
              Container(
                alignment: Alignment.center,
                height: alturaselector,
                width: 80,
                decoration: BoxDecoration(
                color: widget.colorleft.withValues(alpha: 0.1),
                borderRadius: widget.rounded ? BorderRadius.circular(100) : BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 1.5,
                )
                ),
              )
            )
            ]
          )
    );
  }
}

















