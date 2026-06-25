import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/Mapa.dart';
import 'package:flutter_application_1/page/Pruebas.dart';
import 'package:flutter_application_1/service/SocketService.dart';
import 'package:flutter_application_1/service/StreamingService.dart';
import 'package:flutter_application_1/widget/buttombar/BarraNavegacion.dart';
import 'package:flutter_application_1/widget/topbar/TopBar.dart';


class Application extends StatefulWidget{  

  final _socket = SocketService();
  final _streaming = StreamingService.getInstance();

  Application({super.key});
  @override
  State<Application> createState() => _Home();
}

class _Home extends State<Application>{


  int _selectedIndex = 0;
  List<CustomPaint> lineasmapa = [];
  
  @override
  void initState() {
    super.initState();
    widget._socket.connect();
    widget._streaming.mensajes.listen((data){print(data);});
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pantalla = [Mapa(), Pruebas()];

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