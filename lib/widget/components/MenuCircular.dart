import 'dart:ui';
import 'package:flutter/material.dart';

/* Para usar este widget es necesario enviarle el icono del menu
y adicionalmente 4 herramientas, este valor es constante de modo que si se requieren menos
lo ideal es enviar containers vacios en los espacios faltantes, esto para poder organizar bien
la posicion de los objetos alrededor del menu principal.
Nada como un menu al estilo Arma 3 con Ace, lastima que no puedo copiar los iconos del juego
para ponerlos aqui.
By Lenin Ospina* */

class MenuCircular extends StatefulWidget {

  final Widget menu;
  final List<Widget> herramientas;
  final VoidCallback fnc1;

  MenuCircular({
    super.key,
    required this.menu,
    required this.herramientas,
    required this.fnc1
  });
  
  @override
  State<StatefulWidget> createState() => _Tools();
  
}

class _Tools extends State<MenuCircular> {
  double _borrado = 0.0;
  bool _expandir = false;

  void fnc_expandir() { // me empiezan a gustar los callback
    setState(() {
      _borrado = _borrado == 0.0 ? 6.0 : 0.0;
      _expandir = !_expandir;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
    bottom: 100,
    right: 10,
    child:
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _borrado, sigmaY: _borrado),
      child: 
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
          height: _expandir? 200 : 45,
          width: _expandir? 200 : 50,
          margin: EdgeInsets.only(left: 5, top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromARGB(200, 255, 252, 252)
          ),
          child: _expandir ? 
            _Herramientas(herramientas: widget.herramientas, menu: widget.menu, 
                          fnc_expandir: fnc_expandir, fnc1: widget.fnc1,)
            : 
            GestureDetector(
              onTap: fnc_expandir,
              child: 
                widget.menu
                )
        )
      )
    );
  } 
}

class _Herramientas extends StatelessWidget{ // lo separe en otra clase porque eso arriba ya estaba muy largo
  final List<Widget> herramientas;
  final Widget menu;
  final VoidCallback fnc_expandir;
  final VoidCallback fnc1;

  const _Herramientas ({super.key, 
  required this.herramientas,
  required this.menu,
  required this.fnc_expandir,
  required this.fnc1});

  @override
  Widget build(BuildContext context) {
    return Stack( 
      alignment: Alignment.center,
      children: [ 
        Positioned(
        top: 13,
        child: 
        GestureDetector(                            
          onTap: (){
                  fnc1();
                  fnc_expandir();},
          child: 
            herramientas[0]
          )
        ),
        Positioned(
        bottom: 90,
        left: 15,
        child: 
          GestureDetector(                            
          onTap: () => print("presionado"),
          child: 
            herramientas[1]
          )
        ),
        Positioned(
        bottom: 90,
        right: 15,
        child: 
          GestureDetector(                            
          onTap: () => print("presionado"),
          child: 
            herramientas[2]
          )
        ),
        Positioned(
        bottom: 15,
        left: 90,
        child: 
          GestureDetector(                            
          onTap: () => print("presionado"),
          child: 
            herramientas[3]
          )
        ),
        Positioned(
          child: GestureDetector(
            onTap: fnc_expandir,
            child: menu,
            )
          )
      ]);

  }
}